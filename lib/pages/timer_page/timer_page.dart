import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/pages/timer_page/widgets/interval_timer_controls.dart';
import 'package:fitness_app/pages/timer_settings_page/timer_settings_page.dart';

class TimerPage extends StatefulWidget
{
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
  @override
  Widget build(BuildContext context)
  {
    var intervalTimer = context.watch<IntervalTimer>();
    intervalTimer.removeEmptyRounds();
    


    return Stack(
      children: [
        Scaffold(
          backgroundColor: workColor,
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buildContent(intervalTimer)
            ),
          ),
        ),
        Positioned(
          top: 0,
          right:0,
          child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TimerSettingsPage(),
                    ),
                  );
                },
                child: Icon(Icons.settings),
            ),
        ),
      ],
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
                  intervalTimer.getRoundProgress(),
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
