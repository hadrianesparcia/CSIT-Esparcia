import 'package:flutter/material.dart';
import 'questions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuizApp(),
  ));
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  String screen = 'start';
  int questionIndex = 0;
  List<String> userAnswers = [];

  void startQuiz() {
    setState(() {
      screen = 'questions';
      questionIndex = 0;
      userAnswers = [];
    });
  }

  void selectAnswer(String answer) {
    userAnswers.add(answer);

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      setState(() {
        screen = 'results';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      screen = 'start';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (screen == 'start') {
      content = buildStartScreen();
    } else if (screen == 'questions') {
      content = buildQuestionScreen();
    } else {
      content = buildResultsScreen();
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF060258), Color(0xFF8005A5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(child: content),
        ),
      ),
    );
  }

  Widget buildStartScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.live_help_outlined,
          size: 100,
          color: Colors.white.withValues(alpha: 0.7),
        ),
        const SizedBox(height: 30),
        const Text(
          'Learn Flutter the fun way!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        TextButton.icon(
          onPressed: startQuiz,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.arrow_right_alt),
          label: const Text('Start Quiz'),
        ),
      ],
    );
  }

  Widget buildQuestionScreen() {
    final currentQuestion = questions[questionIndex];
    final answers =
        List<String>.from(currentQuestion['answers'] as List);

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentQuestion['question'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          for (final answer in answers)
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: ElevatedButton(
                onPressed: () => selectAnswer(answer),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF30054F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(answer),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildResultsScreen() {
    int correctCount = 0;

    for (int i = 0; i < userAnswers.length; i++) {
      final correctAnswer = (questions[i]['answers'] as List)[0];

      if (userAnswers[i] == correctAnswer) {
        correctCount++;
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Text(
              'You answered $correctCount out of ${questions.length} questions correctly!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            for (int i = 0; i < userAnswers.length; i++)
              buildResultRow(i),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultRow(int i) {
    final correctAnswer =
        (questions[i]['answers'] as List)[0] as String;
    final wasCorrect = userAnswers[i] == correctAnswer;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: wasCorrect
                ? const Color(0xFF30B2FF)
                : const Color(0xFFD6489A),
            child: Text('${i + 1}'),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questions[i]['question'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  userAnswers[i],
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  correctAnswer,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}