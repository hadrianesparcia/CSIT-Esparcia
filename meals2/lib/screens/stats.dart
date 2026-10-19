import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data received through the named route
    final stats =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final e in stats.entries)
            Card(
              child: ListTile(
                title: Text(e.key),
                trailing: Text(
                  '${e.value}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
        ],
      ),
    );
  }
}