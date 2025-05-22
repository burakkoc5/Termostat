import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/thermostat_provider.dart';
import 'providers/usage_provider.dart';
import 'providers/location_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/automation_screen.dart';

class ThermostatApp extends StatelessWidget {
  const ThermostatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThermostatProvider()),
        ChangeNotifierProvider(create: (_) => UsageProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        title: 'Smart Thermostat',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (_) => const _AppScaffold(child: DashboardScreen()),
          '/history': (_) => const _AppScaffold(child: HistoryScreen()),
          '/settings': (_) => const _AppScaffold(child: SettingsScreen()),
          '/automation': (_) => const _AppScaffold(child: AutomationScreen()),
        },
      ),
    );
  }
}

class _AppScaffold extends StatelessWidget {
  final Widget child;
  const _AppScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Smart Thermostat')),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            ListTile(
              title: const Text('History'),
              onTap: () => Navigator.pushReplacementNamed(context, '/history'),
            ),
            ListTile(
              title: const Text('Automation'),
              onTap: () => Navigator.pushReplacementNamed(context, '/automation'),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () => Navigator.pushReplacementNamed(context, '/settings'),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
} 