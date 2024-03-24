import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Import your existing components and pages
import 'components/bottom_navigation_bar.dart';
import 'components/home.dart';
import 'components/info.dart';
import 'components/login.dart';
import 'components/map.dart';
import 'components/notification.dart';
import 'firebase_options.dart';
// Import your phone authentication page
import 'phone_auth_page.dart';

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          AuthenticationWrapper(), // Use AuthenticationWrapper instead of MyMainPage
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  // Flag to determine if user is authenticated
  bool _isAuthenticated = false;

  // Method to set authentication status
  void _setAuthenticated(bool isAuthenticated) {
    setState(() {
      _isAuthenticated = isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    // If user is authenticated, show main page
    if (_isAuthenticated) {
      return MyMainPage();
    }
    // Otherwise, show phone authentication page
    else {
      return PhoneAuthPage(onAuthenticated: _setAuthenticated);
    }
  }
}

// The rest of your code remains unchanged

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MyHomePage(),
    InformationPage(),
    MapScreen(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigation(
        initialIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
