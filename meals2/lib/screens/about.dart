import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            SizedBox(height: 16),
            Text('Hadrian Esparcia', style: TextStyle(fontSize: 22)),
            Text('CSIT284 G02'),
            SizedBox(height: 16),
            Text('Meals App - built with Flutter for Topic 8: Navigation.'),
          ],
        ),
      ),
    );
  }
}