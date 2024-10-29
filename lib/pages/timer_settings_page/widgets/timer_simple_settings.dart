import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/pages/timer_page/widgets/time_display.dart';

class TimerSimpleSettings extends StatefulWidget
{
  @override
  State<TimerSimpleSettings> createState() => _TimerSimpleSettingState();
}

class _TimerSimpleSettingState extends State<TimerSimpleSettings>
{

  double _fontSize = 30;
  double _paddingBetweenItems = 15.0;

  Widget buildDisplay(IntervalTimer interval_timer)
  {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Total Rounds",
          style: TextStyle(fontSize: _fontSize)),
          Text("${interval_timer.rounds.length}",
          style: TextStyle(fontSize: _fontSize)),
          Padding(padding: EdgeInsets.all(_paddingBetweenItems)),
          Column(
              children: [
                Text(
                "Work",
                style: TextStyle(fontSize: _fontSize)
                ),
                TimeDisplay(
                  time: interval_timer.rounds[0].phaseTimers[0].getWorkTime(),  
                  timeColor: Colors.black,
                  onTimeChanged:( (time) {
                    setState((){interval_timer.setAllRoundsWorkTime(time);});
                  })
                ),
                Padding(padding: EdgeInsets.all(_paddingBetweenItems)),
                Text(
                  "Rest",
                  style: TextStyle(fontSize: _fontSize)
                ),
                TimeDisplay(
                  time: interval_timer.rounds[0].phaseTimers[0].getRestTime(),  
                  timeColor: Colors.black,
                  onTimeChanged:( (time) {
                    setState((){interval_timer.setAllRoundsWorkTime(time);});
                  })
                )
              ]
            ),
            
          Padding(padding: EdgeInsets.all(_paddingBetweenItems)),
          Text("Total Time",
          style: TextStyle(fontSize: _fontSize)),
          Text("${interval_timer.getTotalTime()}",
          style: TextStyle(fontSize: _fontSize))
      
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    IntervalTimer intervalTimer = context.watch<IntervalTimer>();

    return Center(
      child: buildDisplay(intervalTimer)
    );
  }
}