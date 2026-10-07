import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget{
  const DiceRoller({super.key});
  
  @override
  State<DiceRoller>createState() {
    
    return _DiceRollerState();  
  }

}

class _DiceRollerState extends State<DiceRoller> {

  final randomizer = Random();
  var currentDiceImage = 'assets/dice-images/dice-6.png';
  void rollDice() {
    setState(() {
      int num = randomizer.nextInt(6) + 1;
      currentDiceImage = 'assets/dice-images/dice-$num.png';
    });
      
  }

  @override
  Widget build(context) {
    return Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              width: 150, 
              currentDiceImage
              ),
            SizedBox(height: 50, ),
            TextButton(onPressed: rollDice, 
            child: Text(
              style: TextStyle(fontSize: 28, color: Colors.deepOrange),
              "Roll Dice"))
          ],
      );
  }  
}

//stateful widget needs two classess