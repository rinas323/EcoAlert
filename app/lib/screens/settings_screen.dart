import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return const Center(
              child: Text('Settings Screen - Wide Layout'),
            );
          } else {
            return const Center(
              child: Text('Settings Screen - Narrow Layout'),
            );
          }
        },
      ),
    );
  }
}
