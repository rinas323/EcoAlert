import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/capture_screen.dart';
import 'screens/map_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/guide_screen.dart';
import 'screens/municipality_screen.dart';
import 'store/report_store.dart';

void main() {
  runApp(const EcoAlertApp());
}

class EcoAlertApp extends StatelessWidget {
  const EcoAlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green));
    final theme = base.copyWith(
      useMaterial3: true,
      textTheme: base.textTheme.apply(bodyColor: Colors.black87, displayColor: Colors.black87),
      appBarTheme: const AppBarTheme(centerTitle: true),
      cardTheme: CardThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    );
    return ChangeNotifierProvider(
      create: (_) => ReportStore(),
      child: MaterialApp(
        title: 'EcoAlert Kerala',
        theme: theme,
        home: const HomeShell(),
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _screens = <Widget>[
    CaptureScreen(),
    MapScreen(),
    ReportsScreen(),
    GuideScreen(),
    MunicipalityScreen(),
  ];

  static const _titles = <String>[
    'Capture',
    'Map',
    'Reports',
    'Guide',
    'Municipalities',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoAlert • ${_titles[_index]}'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _screens[_index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.camera_alt_outlined), selectedIcon: Icon(Icons.camera_alt), label: 'Capture'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.list_alt_outlined), selectedIcon: Icon(Icons.list_alt), label: 'Reports'),
          NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Guide'),
          NavigationDestination(icon: Icon(Icons.apartment_outlined), selectedIcon: Icon(Icons.apartment), label: 'Municipal'),
        ],
      ),
    );
  }
}
