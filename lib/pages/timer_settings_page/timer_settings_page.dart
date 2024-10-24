import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/pages/timer_page/widgets/round_card.dart';

class TimerSettingsPage extends StatefulWidget {

  @override
  State<TimerSettingsPage> createState() => _TimerSettingsPage();
}

class _TimerSettingsPage extends State<TimerSettingsPage> {
  
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

  List<Widget> buildContent(IntervalTimer intervalTimer)
    {
      // Display all of the editable rounds
      return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: ((){
              setState(intervalTimer.addRound);
            }),
            child: Icon(Icons.add),
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
  Widget build(BuildContext context) {
    var intervalTimer = context.watch<IntervalTimer>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: 
          Row(
            children: [
              OutlinedButton(
                onPressed: (){
              
                },
                child: Text(
                  "Simple",
                  style: TextStyle(
                  color: Theme.of(context).colorScheme.surface
                  )
                )
              ),
              ElevatedButton(onPressed: (){
              
              },
              child: Text("Advanced")),
            ],
          )
      ),
      body: Column(
        children:
          buildContent(intervalTimer)
      )
    );
  }
}
