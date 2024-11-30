
import 'package:flutter/material.dart';
import 'package:fitness_app/common/widgets/time_display.dart';

class QuickStart extends StatelessWidget
{
  final Function onPressed;
  String text = "Quickstart";

  QuickStart({super.key,
    required Function this.onPressed,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      color: Colors.white,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: ()=> onPressed(), child: Text(text)),
            
          ElevatedButton(
            onPressed: ()=> onPressed(), child: Text(text)),
        ],
      ),
    ); 
  }
}