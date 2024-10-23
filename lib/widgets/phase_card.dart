import 'package:flutter/material.dart';
import 'package:fitness_app/models/phase_timer.dart';
import 'time_display.dart';

/// Displays [PhaseTimer._workTime] and [PhaseTimer._restTime] time for a given [PhaseTimer]
class PhaseCard extends StatefulWidget {

  late PhaseTimer? timer;
  PhaseCard(PhaseTimer newTimer)
  {
    timer = newTimer;
  }

  @override
  _PhaseCardState createState() => _PhaseCardState();
}

class _PhaseCardState extends State<PhaseCard> {
  // controller information https://docs.flutter.dev/cookbook/forms/text-field-changes
  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TimeDisplay(
            time: widget.timer!.getWorkTime(),
            label: "Work",
            onTimeChanged: ((newWorkTime){
              setState(() {
                widget.timer!.setWorkTime(newWorkTime);
                });
              }),
            ),
            TimeDisplay(
              time: widget.timer!.getRestTime(),
              label: "Rest",
              onTimeChanged: ((newRestTime){
                setState(() {
                  widget.timer!.setRestTime(newRestTime);
                });
              }),
            ),
          ]
        )
      )
    );
  }
}

