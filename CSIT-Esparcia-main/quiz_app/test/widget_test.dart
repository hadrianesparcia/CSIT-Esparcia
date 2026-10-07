import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_app/main.dart';

void main() {
  testWidgets('Quiz app shows start screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
    ));

    expect(find.text('Learn Flutter the fun way!'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
  });
}