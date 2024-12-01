
import 'package:flutter/material.dart';

class TimerHelp extends StatelessWidget
{
  final double textSize;
  TimerHelp({
    super.key, 
    this.textSize = 25.0
  });

  Future<void> _buildPopUp(BuildContext context)
  {
    return showDialog<void>(
      barrierDismissible: false,
      context:  context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text("Editor Usage",
              style: TextStyle(fontSize: textSize + 5)
            )
          ),
          content: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: textSize),
              children: [
                TextSpan(
                  text:  "Two timer editors:\n\n"
                ),
                TextSpan(
                  text:  "Simple Editor ",
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                TextSpan(
                  text: "for basic timers where the work and rest time are constant\n\n"
                ),
                TextSpan(
                  text: "Advanced Editor ",
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                TextSpan(
                  text: "for timers with varying work and rest time",
                )
              ]
            )
           
           
          ),
          actions: [
            ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("CLOSE")),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: CircleBorder()
      ),
      onPressed: ()=> _buildPopUp(context), 
      child: Icon(Icons.help)
    );
  }
}