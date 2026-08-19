import 'package:flutter/material.dart';



class StyledText extends StatelessWidget{
  StyledText({super.key});
  @override
  Widget build(context) {
    return Text(
          'Hello World',
          style: TextStyle(
            fontSize: 220,
            color: Colors.pink,
          ),
          );
  }

  
}