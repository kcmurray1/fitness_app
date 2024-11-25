import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/interval_timer.dart';

/// Displays [IntervalTimer] for user to interact with the timer
class TimerPage extends StatefulWidget
{
  final IntervalTimer? timer;
  
  /// Creates [TimerPage] that listens to parent
  /// Widget containing a [IntervalTimer] provider. <br>
  /// This TimerPage will optionally listen to timer, if provided.
  TimerPage({
    super.key,
    this.timer
  });

  @override
  State<TimerPage> createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage>
{
  Color restColor = Color.fromARGB(175, 226, 86, 86);
  Color workColor = Color.fromARGB(207, 125, 220, 91);


  List<Widget> buildContent(IntervalTimer intervalTimer)
    {
      return [

          buildTimerDisplay(intervalTimer), 
          buildButton(intervalTimer, context),
        ];
     
    }
  
  Color _toggleBackgroundColor(bool isWork, bool status)
  {
    if(!status)
    {
      return Colors.white;
    }
    if(isWork)
    {
      return workColor;
    }
    return restColor;
  }

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

  @override
  Widget build(BuildContext context)
  {
    var intervalTimer = widget.timer ?? context.watch<IntervalTimer>();
    intervalTimer.removeEmptyRounds();

    return Scaffold(
            backgroundColor: _toggleBackgroundColor(intervalTimer.getCurrentRound.isWorkPhase, intervalTimer.isStarted),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildContent(intervalTimer)
              ),
            ),
          );
  }
}


Widget buildTimerDisplay(IntervalTimer intervalTimer)
{
  return  Column(
              children: [
                Text(
                  "Round: ${intervalTimer.round}",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold
                  )
                ),
                Text(
                  intervalTimer.getRoundProgress,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                ),

                Text(
                  intervalTimer.getCurrentTime(),
                  style: TextStyle(fontSize: 75),
                  // style: Theme.of(context).textTheme.headlineMedium,
                ),
                  
              ],
            );
}
