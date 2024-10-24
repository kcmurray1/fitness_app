import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/interval_timer.dart';


class TimerSimpleSettings extends StatefulWidget
{
  @override
  State<TimerSimpleSettings> createState() => _TimerSimpleSettingState();
}

class _TimerSimpleSettingState extends State<TimerSimpleSettings>
{
  Widget buildDisplay(IntervalTimer interval_timer)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Text("Total Rounds: ${interval_timer.rounds.length}"),
        Text("Work Time"),
        Text("Rest Time"),
        Text("Total Time")

      ],
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