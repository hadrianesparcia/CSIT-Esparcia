import 'package:flutter/material.dart';

class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({super.key, required this.startQuiz});

  final VoidCallback startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 250,
          ),
          const SizedBox(height: 40),
          const Text(
            'EAT FOOD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: startQuiz,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start'),
          ),
        ],
      ),
    );
  }
}