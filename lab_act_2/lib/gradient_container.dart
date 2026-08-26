import 'package:flutter/material.dart';
import 'package:lab_act_2/dice_roller.dart';
import 'styled_text.dart';
 
class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});
 

 
  @override
  Widget build(context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red,
              Colors.white
            ])
        ),
        child: Center(
          child: DiceRoller()
        ),
    );
  }  
  }