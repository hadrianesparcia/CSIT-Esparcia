import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_homescreen.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  String activeScreen = 'start-screen';
  List<String> selectedAnswers = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == 6) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  // Dynamic gradient colors calculation based on performance
  List<Color> getGradientColors() {
    if (activeScreen == 'results-screen') {
      int score = 0;
      for (int i = 0; i < selectedAnswers.length; i++) {
        if (selectedAnswers[i] == questions[i]['answers'][0]) {
          score++;
        }
      }
      // >= 60% (3 out of 6): Purple to Green gradient
      // < 60% (score < 3): Purple to Red gradient
      return score >= 3
          ? [Colors.deepPurple, Colors.green.shade700]
          : [Colors.deepPurple, Colors.red.shade700];
    }
    // Default background gradient for start and question screens
    return [Colors.deepPurple, Colors.indigo.shade900];
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = QuizHomeScreen(startQuiz: switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: getGradientColors(),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}

// Global static dataset: 6 questions with 3-4 options each (first index is correct answer)
final List<Map<String, dynamic>> questions = [
  {
    'question': 'What flavor do you enjoy most?',
    'answers': ['Sweet (SL) ', 'Salty (SF)', 'Spicy (SE)', 'Sour (SF) '],
  },
  {
    'question': 'Which snack would you choose?',
    'answers': ['Cake (SL) ', 'Fries (SF)', 'Nachos (SF) ', 'Fruit (HC) '],
  },
  {
    'question': 'What would you most likely order at a restaurant? ',
    'answers': ['Dessert (SL) ', 'Burger (SF) ', 'Chicken Wings (SE) ', 'Salad (HC) '],
  },
];
