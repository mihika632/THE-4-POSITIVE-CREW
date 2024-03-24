import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Misconceptions about Blood Donation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'You may have read or heard about some misconceptions about blood donation. Let’s unveil the truth here.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '1. Blood donation is very painful.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'The needle prick feels like a pinch on the arm. A local anaesthetic will be administered by a trained and competent staff to ensure that you feel minimal pain during the donation.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '2. Blood donation is good for health.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Only healthy people can donate blood. Hence, donating blood is a sign of good health. Although there is no scientific evidence to show that blood donation has direct health benefits, many donors shared that they feel good after knowing they have helped others which is a good booster to their emotional well-being.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Copyright © 2024 BloodShare. All rights reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Authors: The 4+ Positive Crew',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
