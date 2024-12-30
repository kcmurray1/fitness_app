import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/utilities/interval_timer.dart';

/// Displays [IntervalTimer] for user to interact with the timer
class TimerPage extends StatefulWidget
{
  final IntervalTimer? timer;
  final Color restColor;
  final Color workColor;
  
  /// Creates [TimerPage] that listens to parent
  /// Widget containing a [IntervalTimer] provider. <br>
  /// This TimerPage will optionally listen to timer, if provided.
  TimerPage({
    super.key,
    this.timer,
    required this.restColor,
    required this.workColor
  });

  @override
  State<TimerPage> createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage>
{ 
  Color _toggleBackgroundColor(bool isWork, bool status)
  {
    if(!status)
    {
      return Colors.white;
    }
    if(isWork)
    {
      return widget.workColor;
    }
    return widget.restColor;
  }

  /// Create Start, Pause, Restart, and Cancel buttons based on the
  /// state of this [IntervalTimer]
  Widget buildTimerControl(IntervalTimer timer, BuildContext context)
  {
    // Display start button
    if (!timer.isStarted)
    {
      return buildCustomButton(
        text: "START",
        context: context,
        height: 70,
        fontSize: 30,
        onHold: (){},
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
              text: timer.isRunning() ? "PAUSE" : "RESUME",
              context: context,
              onHold: (){},
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
        ]
      ); 
    }
  }

  // Provided by ChatGPT
  Widget buildCustomButton({
    required String text,
    required VoidCallback onPressed,
    required VoidCallback onHold,
    required BuildContext context,
    double width = 300,
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
        onLongPress: onHold,
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


  
  Widget buildTimerDisplay(IntervalTimer intervalTimer)
  {
    return  Column(
                children: [
                  Text(
                    "Round: ${intervalTimer.round}",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  if(!intervalTimer.isSingleRound())
                  Text(
                    intervalTimer.getRoundProgress,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Padding(padding: EdgeInsets.all(25)),
                  Text(
                    intervalTimer.getCurrentTime(),
                    style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold)
                    ),
                    
                ],
              );
  }

  @override
  Widget build(BuildContext context)
  {
    var intervalTimer = widget.timer ?? context.watch<IntervalTimer>();
    intervalTimer.removeEmptyRounds();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult:(didPop, result){},
      child: Scaffold(
              backgroundColor: _toggleBackgroundColor(intervalTimer.getCurrentRound.isWorkPhase, intervalTimer.isStarted),
              body: Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    buildCustomButton(
                      text: "HOLD TO EXIT",
                      context: context,
                      onPressed: (){},
                      onHold: ()
                      {
                        intervalTimer.stop();
                        Navigator.of(context).pop();
                      },
                    ),
                    buildTimerDisplay(intervalTimer), 
                    buildTimerControl(intervalTimer, context)
                  ]
                ),
              ),
            ),
    );
  }
}


