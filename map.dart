import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;
  List<Location> _firebaseLocations = [];
  Position? _currentPosition;
  final FirebaseService _firebaseService =
      FirebaseService(); // Instantiate FirebaseService

  @override
  void initState() {
    super.initState();
    _initializeFirebase(); // Initialize Firebase
    _fetchLocations();
    _fetchCampLocations();
  }

  Future<void> _initializeFirebase() async {
    try {
      await _firebaseService.initialize();
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  Future<void> _fetchLocations() async {
    final databaseReference =
        FirebaseDatabase.instance.ref().child('BloodBankRegistrations');
    try {
      DataSnapshot snapshot =
          await databaseReference.once().then((event) => event.snapshot);
      dynamic values = snapshot.value;

      if (values == null || values is! Map<dynamic, dynamic>) {
        throw 'Invalid data format or no data available';
      }

      Map<dynamic, dynamic> dataMap = values as Map<dynamic, dynamic>;

      dataMap.forEach((key, value) {
        double latitude = double.tryParse(value['Latitude'].toString()) ?? 0.0;
        double longitude =
            double.tryParse(value['Longitude'].toString()) ?? 0.0;
        _firebaseLocations.add(Location(
            latitude: latitude,
            longitude: longitude,
            type: LocationType.BloodBank)); // Set type to BloodBank
      });

      setState(() {});
    } catch (error) {
      print('Error fetching locations: $error');
    }
  }

  Future<void> _fetchCampLocations() async {
    final databaseReference =
        FirebaseDatabase.instance.ref().child('CampRegistrations');
    try {
      DataSnapshot snapshot =
          await databaseReference.once().then((event) => event.snapshot);
      dynamic values = snapshot.value;

      if (values == null || values is! Map<dynamic, dynamic>) {
        throw 'Invalid data format or no data available';
      }

      Map<dynamic, dynamic> dataMap = values as Map<dynamic, dynamic>;

      dataMap.forEach((key, value) {
        double latitude = double.tryParse(value['Latitude'].toString()) ?? 0.0;
        double longitude =
            double.tryParse(value['Longitude'].toString()) ?? 0.0;
        _firebaseLocations.add(Location(
            latitude: latitude,
            longitude: longitude,
            type: LocationType.Camp)); // Set type to Camp
      });

      setState(() {});
    } catch (error) {
      print('Error fetching locations: $error');
    }
  }

  void _fetchBloodGroupData(double latitude, double longitude) async {
    try {
      DatabaseEvent event = await _firebaseService.bloodGroupRef.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> bloodGroupData =
            snapshot.value as Map<dynamic, dynamic>;
        String? bloodGroup = bloodGroupData['$latitude-$longitude'];
        if (bloodGroup != null) {
          _showBloodGroupPopup(context, bloodGroup);
        } else {
          _showBloodGroupPopup(
              context, "Blood group data not found for this location.");
        }
      } else {
        _showBloodGroupPopup(context, "Blood group data not found.");
      }
    } catch (error) {
      print("Error fetching blood group data: $error");
      _showBloodGroupPopup(context, "Error fetching blood group data");
    }
  }

  void _showBloodGroupPopup(BuildContext context, String bloodGroupData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Blood Group Data"),
          content: Text(bloodGroupData),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool enableLocationServices = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enable Location Services"),
            content: Text("Please enable location services to use this app."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );

      if (!enableLocationServices) {
        return Future.error('Location services are disabled.');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    if (_currentPosition != null) {
      setState(() {
        _firebaseLocations.add(Location(
            latitude: _currentPosition!.latitude,
            longitude: _currentPosition!.longitude));
      });

      _googleMapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          15, // Zoom level
        ),
      );
    }
  }

  final BitmapDescriptor blueMarker =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  final BitmapDescriptor purpleMarker =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
  final BitmapDescriptor greenMarker =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Adjust height of the AppBar
        child: AppBar(
          actions: [
            Center(
              child: Image.asset("assets/logo.png"),
            )
          ],
          centerTitle: true,
          title: Text(
            'BloodShare',
            style: TextStyle(
              fontSize: 24, // Adjust font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _googleMapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 2,
            ),
            markers: _firebaseLocations.map((location) {
              BitmapDescriptor markerIcon;
              // Determine marker color based on location type
              if (location.type == LocationType.User) {
                markerIcon = blueMarker;
              } else if (location.type == LocationType.BloodBank) {
                markerIcon = purpleMarker;
              } else if (location.type == LocationType.Camp) {
                markerIcon = greenMarker;
              } else {
                markerIcon = BitmapDescriptor.defaultMarker;
              }
              return Marker(
                markerId:
                    MarkerId('${location.latitude}-${location.longitude}'),
                position: LatLng(location.latitude, location.longitude),
                icon: markerIcon,
                onTap: () {
                  // Fetch blood group data and display in a pop-up
                  _fetchBloodGroupData(location.latitude, location.longitude);
                },
              );
            }).toSet(),
          ),
          Positioned(
            bottom: 16,
            left: MediaQuery.of(context).size.width / 2 -
                28, // Adjusted to center horizontally
            child: FloatingActionButton(
              onPressed: _determinePosition,
              child: Icon(Icons.location_on),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem("User Location", blueMarker),
                  _buildLegendItem("Blood Bank", purpleMarker),
                  _buildLegendItem("Camp", greenMarker),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, BitmapDescriptor icon) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: icon == blueMarker
              ? Colors.blue
              : icon == purpleMarker
                  ? Colors.purple
                  : Colors.pink,
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Location {
  final double latitude;
  final double longitude;
  final LocationType type;

  Location({
    required this.latitude,
    required this.longitude,
    this.type = LocationType.User,
  });
}

enum LocationType {
  User,
  BloodBank,
  Camp,
}

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  FirebaseService._internal();

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  DatabaseReference get bloodGroupRef =>
      FirebaseDatabase.instance.ref().child("BloodGroupInventory");
}
