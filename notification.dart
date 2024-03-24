import 'package:flutter/material.dart';

class NotificationTuple {
  final String title;
  final String message;
  final String time;

  NotificationTuple(
      {required this.title, required this.message, required this.time});
}

class NotificationPage extends StatelessWidget {
  final List<NotificationTuple> notifications = [
    NotificationTuple(
      title: 'New message from John',
      message: 'Hey, what\'s up?',
      time: '10:30 AM',
    ),
    NotificationTuple(
      title: 'Reminder',
      message: 'Don\'t forget the meeting at 3 PM',
      time: 'Yesterday',
    ),
    NotificationTuple(
      title: 'News Update',
      message: 'Check out the latest news article',
      time: '2 days ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return NotificationTile(
            title: notifications[index].title,
            message: notifications[index].message,
            time: notifications[index].time,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey[300],
            thickness: 1.0,
            height: 0.0,
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final String time;

  NotificationTile(
      {required this.title, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        onTap: () {
          // Add action when notification is tapped
        },
      ),
    );
  }
}

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationPage(),
    );
  }
}
