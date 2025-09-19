import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return const Center(
              child: Text('Notifications Screen - Wide Layout'),
            );
          } else {
            return const Center(
              child: Text('Notifications Screen - Narrow Layout'),
            );
          }
        },
      ),
    );
  }
}
