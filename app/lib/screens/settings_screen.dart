import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueGrey),
                  title: const Text('Account'),
                  onTap: () {
                    // TODO: Implement account screen
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.blueGrey),
                  title: const Text('Language'),
                  subtitle: const Text('English'),
                  onTap: () {
                    // TODO: Implement language selection
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications, color: Colors.blueGrey),
                  title: const Text('Enable Notifications'),
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode, color: Colors.blueGrey),
                  title: const Text('Enable Dark Mode'),
                  value: _darkModeEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.blueGrey),
                  title: const Text('About'),
                  onTap: () {
                    // TODO: Implement about screen
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help, color: Colors.blueGrey),
                  title: const Text('Help & Feedback'),
                  onTap: () {
                    // TODO: Implement help & feedback screen
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    // TODO: Implement logout
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}