import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'screens/capture_screen.dart';
import 'screens/map_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/guide_screen.dart';
import 'screens/municipality_screen.dart';
import 'store/report_store.dart';
import 'store/theme_provider.dart';
import 'widgets/custom_app_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('ml')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const EcoAlertApp(),
    ),
  );
}

class EcoAlertApp extends StatelessWidget {
  const EcoAlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReportStore()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final base = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green));
          final theme = base.copyWith(
            useMaterial3: true,
            textTheme: base.textTheme.apply(bodyColor: Colors.black87, displayColor: Colors.black87),
            appBarTheme: const AppBarTheme(centerTitle: true),
            cardTheme: CardThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          );

          final darkTheme = ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
            cardTheme: CardThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          );

          return MaterialApp(
            title: 'EcoAlert Kerala',
            theme: theme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const HomeShell(),
          );
        },
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
      appBar: CustomAppBar(
        title: _titles[_index],
        showLogo: true, // Show logo only on home/capture screen
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _screens[_index],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          backgroundColor: Colors.white,
          indicatorColor: Colors.green.shade100,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.camera_alt_outlined), 
              selectedIcon: Icon(Icons.camera_alt, color: Colors.green), 
              label: 'Capture'
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined), 
              selectedIcon: Icon(Icons.map, color: Colors.green), 
              label: 'Map'
            ),
            NavigationDestination(
              icon: Icon(Icons.list_alt_outlined), 
              selectedIcon: Icon(Icons.list_alt, color: Colors.green), 
              label: 'Reports'
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined), 
              selectedIcon: Icon(Icons.school, color: Colors.green), 
              label: 'Guide'
            ),
            NavigationDestination(
              icon: Icon(Icons.apartment_outlined), 
              selectedIcon: Icon(Icons.apartment, color: Colors.green), 
              label: 'Municipal'
            ),
          ],
        ),
      ),
    );
  }
}
