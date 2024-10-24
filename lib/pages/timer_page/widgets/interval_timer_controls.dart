import 'package:flutter/material.dart';
import 'package:fitness_app/models/interval_timer.dart';

/// Create Start, Pause, Restart, and Cancel buttons based on the
/// state of this [IntervalTimer]
Widget buildButton(IntervalTimer timer, BuildContext context)
{
  // Display start button
  if (!timer.isStarted)
  {
    return buildCustomButton(
      text: "Start",
      context: context,
      width: 300,
      height: 70,
      fontSize: 30,
      onPressed: ()
      {
        timer.startRound();
      },
    );
  }
  // Display pause and cancel button
  else
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!timer.isComplete())
          // display 'pause' button during countown then switch to 'resume'
          // after pressing pause
          buildCustomButton(
            text: timer.isRunning() ? "pause" : "resume",
            context: context,
            onPressed: ()
            {
              if (timer.isRunning())
              {
                timer.stop(reset: false);
              }
              else
              {
                timer.startRound();
              }
              
            },
          ),
        // Display cancel button during the countdown
        // Display restart button when IntervalTimer is comeplete
        buildCustomButton(
          text: timer.isRunning() ? "cancel" : "restart",
          context: context,
          onPressed: ()
          {
            timer.stop();
          }, 
        ),
      ]
    ); 
  }
}

// Provided by ChatGPT
Widget buildCustomButton({
  required String text,
  required VoidCallback onPressed,
  required BuildContext context,
  double width = 180,
  double height = 65,
  Color? color,
  double fontSize = 20,
})
{
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).colorScheme.primary
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize
          )
        ),
      )
    );

}