import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../store/theme_provider.dart';
import 'about_screen.dart';
import 'help_and_feedback_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('language'.tr()),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text('english'.tr()),
                  onTap: () {
                    context.setLocale(const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('hindi'.tr()),
                  onTap: () {
                    context.setLocale(const Locale('hi'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('malayalam'.tr()),
                  onTap: () {
                    context.setLocale(const Locale('ml'));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
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
                  leading: const Icon(Icons.person),
                  title: Text('account'.tr()),
                  onTap: () {
                    // TODO: Implement account screen
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('language'.tr()),
                  subtitle: Text(context.locale.toString() == 'en' ? 'English' : context.locale.toString() == 'hi' ? 'हिंदी' : 'മലയാളം'),
                  onTap: _showLanguageDialog,
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
                  secondary: const Icon(Icons.notifications),
                  title: Text('enable_notifications'.tr()),
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode),
                  title: Text('enable_dark_mode'.tr()),
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (bool value) {
                    themeProvider.toggleTheme(value);
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
                  leading: const Icon(Icons.info),
                  title: Text('about'.tr()),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: Text('help_feedback'.tr()),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpAndFeedbackScreen()));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text('logout'.tr(), style: const TextStyle(color: Colors.red)),
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
