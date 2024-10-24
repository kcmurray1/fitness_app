import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/pages/timer_page/widgets/round_card.dart';

class TimerAdvancedSettings extends StatefulWidget {
    @override
    State<TimerAdvancedSettings> createState() => _TimerAdvancedSettingState();
}

class _TimerAdvancedSettingState extends State<TimerAdvancedSettings>
{  
    /// Display [IntervalTimer.rounds] as a list containing
    /// editable [RoundCard]
    List<Widget> displayRounds(IntervalTimer intervalTimer)
    {
        List<Widget> rounds = [];
        int roundCount = 1;
        for(var round in intervalTimer.rounds)
        {    
            if(!round.isEmpty())
            {
                rounds.add(RoundCard(
                key: ValueKey(round),
                round: round,
                roundNum: roundCount,
                isDeletable:  true,
                    onRemove: (){
                    setState(() {intervalTimer.removeRound(round);});
                    },
                )
                );
                roundCount++;
            } 
        }
        return rounds;
    }
    
    /// Display detailed controls for this [IntervalTimer] such as
    /// adding/removing [Rounds] and altering the their sets(currently called phaseTimers)
    List<Widget> buildDisplay(IntervalTimer intervalTimer)
    {
        return [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  onPressed: ((){
                  setState(intervalTimer.addRound);
                  }),
                  child: Icon(Icons.add),
              ),
            ),
            
            ],
        ),
        Expanded(
            child: ListView(
            children: displayRounds(intervalTimer),
            )
        )
        ];
    }

    @override
    Widget build(BuildContext context)
    {
        var intervalTimer = context.watch<IntervalTimer>();
        return Column(
            children: buildDisplay(intervalTimer)
        );
    }
}