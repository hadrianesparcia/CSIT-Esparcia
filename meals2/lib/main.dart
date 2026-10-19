import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/about.dart';
import 'screens/stats.dart';
import 'screens/tabs.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (ctx) => const TabsScreen(),
        AppRoutes.about: (ctx) => const AboutScreen(),
        AppRoutes.stats: (ctx) => const StatsScreen(),
      },
    );
  }
}