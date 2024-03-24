import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'map.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
      ),
    ],
    debug: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedBloodGroup;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Simple notification',
          body: 'simple button'),
    );
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 200, // Height of the image slider
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
              ),
              items: [
                // Replace with your image asset paths
                "assets/1.png",
                "assets/3.png",
                "assets/4.png",
                "assets/5.png",
              ].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10),
          // Adjust space between image slider and dropdown
          Center(
            child: DropdownButton<String>(
              value: selectedBloodGroup,
              items: <String>['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedBloodGroup = newValue;
                });
                // Store selected blood group
              },
              hint: Text('Select Required Blood Group'),
            ),
          ),
          SizedBox(height: 10), // Adjust space between dropdown and buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  );
                },
                child: Text('Select'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: triggerNotification,
                child: Text('Emergency / SOS'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Number of containers
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      width: 150,
                      color: Colors.blue[100],
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            _getTextForIndex(index),
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _getTextForIndex(int index) {
  switch (index) {
    case 0:
      return "Blood sustains life,\nDonate and save lives.";
    case 1:
      return "Hospitals need blood,\nYour donation matters.";
    case 2:
      return "Accidents happen,\nBlood donations save.";
    case 3:
      return "Blood has no substitute,\nYour donation counts.";
    case 4:
      return "Surgery or trauma,\nBlood donations heal.";
    default:
      return "Unknown text";
  }
}
