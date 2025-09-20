import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'New Report Submitted',
      'subtitle': 'A new report of illegal dumping has been submitted near your location.',
      'time': '10:00 AM',
      'isRead': false,
    },
    {
      'title': 'Report Status Updated',
      'subtitle': 'Your report #12345 has been updated to "In Progress".',
      'time': 'Yesterday',
      'isRead': false,
    },
    {
      'title': 'Community Alert',
      'subtitle': 'A community cleanup event is scheduled for this Saturday.',
      'time': '2 days ago',
      'isRead': true,
    },
    {
      'title': 'New Feature Available',
      'subtitle': 'You can now track the status of your reports in real-time.',
      'time': 'Last week',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            elevation: 2.0,
            child: ListTile(
              leading: Icon(
                notification['isRead'] ? Icons.mark_email_read : Icons.mark_email_unread,
                color: notification['isRead'] ? Colors.grey : Colors.green,
              ),
              title: Text(
                notification['title'],
                style: TextStyle(
                  fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              subtitle: Text(notification['subtitle']),
              trailing: Text(notification['time']),
              onTap: () {
                setState(() {
                  _notifications[index]['isRead'] = true;
                });
              },
            ),
          );
        },
      ),
    );
  }
}