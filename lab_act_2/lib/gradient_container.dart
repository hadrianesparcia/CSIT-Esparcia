import 'package:flutter/material.dart';
import 'styled_text.dart';

class GradientContainer extends StatelessWidget {
  GradientContainer({super.key});
  @override
  Widget build(context) {
  return Container(
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
        child:StyledText('Hadrian Esparcia'),
          ),
    );

  }
}