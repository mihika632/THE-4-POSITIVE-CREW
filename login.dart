import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhoneAuthPage(),
    );
  }
}

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _verificationId = '';

  Future<void> _verifyPhoneNumber() async {
    // Your verification code logic here
  }

  Future<void> _signInWithPhoneNumber() async {
    // Your sign-in code logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Send OTP'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _signInWithPhoneNumber,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}