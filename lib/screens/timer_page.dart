import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/widgets/interval_timer_buttons.dart';
import 'package:fitness_app/widgets/round_card.dart';


class TimerPage extends StatefulWidget
{
   @override
  _TimerPage createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage>
{

  bool _isRemoveMode = false;

  List<Widget> displayRounds(IntervalTimer intervalTimer)
  {
    List<Widget> rounds = [];
    int roundCount = 1;
    for(var round in intervalTimer.rounds)
    {
      
      if(!round.isEmpty())
      {
        rounds.add(RoundCard(
          round,
          roundCount,
          isDeletable:  _isRemoveMode,
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
  @override
  Widget build(BuildContext context)
  {
    var intervalTimer = context.watch<IntervalTimer>();
    intervalTimer.removeEmptyRounds();

    List<Widget> buildContent()
    {
      if(!_isRemoveMode)
      {
        return [
          buildTimerDisplay(intervalTimer), 
          buildButton(intervalTimer, context),
        ];
      }
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
      if(!intervalTimer.isStarted)
        Expanded(
          child: ListView(
            children: displayRounds(intervalTimer),
          )
        )
      ];
    }

    return Stack(
      children: [
        Scaffold(
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buildContent()
            ),
          ),
        ),
        if(!intervalTimer.isStarted)
        Positioned(
          top: 0,
          right: 0,
          child: ElevatedButton(
            onPressed: ((){
              setState((){_isRemoveMode = !_isRemoveMode;});
            }),
            child: _isRemoveMode ? Icon(Icons.edit_off) : Icon(Icons.edit),
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
