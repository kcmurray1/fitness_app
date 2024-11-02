import 'package:flutter/material.dart';
import 'package:fitness_app/models/phase_timer.dart';
import 'package:fitness_app/pages/timer_page/widgets/time_display.dart';

/// Displays [PhaseTimer._workTime] and [PhaseTimer._restTime] time for a given [PhaseTimer]
class PhaseCard extends StatefulWidget {

  final PhaseTimer? timer;
  PhaseCard({super.key, required this.timer});

  @override
  State<PhaseCard> createState() => _PhaseCardState();
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
          TimeDisplayField(
            time: widget.timer!.getWorkTime(),
            label: "Work",
            onTimeChanged: ((newWorkTime){
              setState(() {
                widget.timer!.setWorkTime(newWorkTime);
                });
              }),
            ),
            TimeDisplayField(
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

