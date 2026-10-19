import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.fastfood, size: 48),
                const SizedBox(width: 18),
                Text('Cooking Up!',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: const Text('Meals'),
            onTap: () => onSelectScreen('meals'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Filters'),
            onTap: () => onSelectScreen('filters'),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Statistics'),
            onTap: () => onSelectScreen('stats'),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () => onSelectScreen('about'),
          ),
        ],
      ),
    );
  }
}