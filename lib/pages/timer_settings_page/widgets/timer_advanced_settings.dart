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
              width: 350,
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
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(myHelper(intervalTimer.getTotalTime()),
            style: TextStyle(fontSize: 30)),
          ],
        )
        ];
    }

    @override
    Widget build(BuildContext context)
    {
        var intervalTimer = context.watch<IntervalTimer>();
        return Container(
          color: Theme.of(context).colorScheme.inversePrimary,
          child: Column(
              children: buildDisplay(intervalTimer)
          ),
        );
    }
}


String myHelper(Duration time)
{
  String h = time.inHours.remainder(60).toString().padLeft(2, '0');
  String m = time.inMinutes.remainder(60).toString().padLeft(2, '0');
  String s = time.inSeconds.remainder(60).toString().padLeft(2, '0');
  return "$h:$m:$s";
}