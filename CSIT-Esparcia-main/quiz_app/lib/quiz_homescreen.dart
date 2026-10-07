import 'package:flutter/material.dart';
import 'dart:math';
 
class QuizHomeScreen extends StatefulWidget{
  const QuizHomeScreen({super.key});
 
  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
 
}
 
class _QuizHomeScreenState extends State<QuizHomeScreen> {
  final randomizer = Random();
 
  Color currentBackgroundColor = Colors.deepPurple;
 
  final List<Color> backgroundColors = [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                            Colors.blue,
                            Colors.purple
                            ];
 
void changeBackgroundColor() {
    setState(() {
      int index = randomizer.nextInt(backgroundColors.length);
      currentBackgroundColor = backgroundColors[index];
    });
  }
 
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: currentBackgroundColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 300,
              ),
              const SizedBox(height: 50),
              const Text(
                'Learn Flutter the fun way!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: changeBackgroundColor,
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}