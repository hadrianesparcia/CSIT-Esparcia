import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(
    backgroundColor: const Color.fromARGB(255, 230, 136, 167),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
          Colors.black,
          Colors.blue
        ])
      ),
      child: Center(
        child: Text(
          'Hello World'),
          ),
    ),
        ),
        ),
        );

}