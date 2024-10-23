import 'package:flutter/material.dart';
import 'package:fitness_app/models/round.dart';
import 'phase_card.dart';
/// Display [PhaseTimers] in this [Round] <br>
/// Provides functionality for adding and removing timers from this [Round]
class RoundCard extends StatefulWidget {
  late Round? round;
  late int roundNum;
  final Function onRemove;
  final bool isDeletable;
  RoundCard(Round newRound, int roundNumber, {required this.isDeletable, required this.onRemove})
  {
    round = newRound;
    roundNum = roundNumber;
  }
  @override
  _RoundCard createState() => _RoundCard();
}

class _RoundCard extends State<RoundCard> {
  // Displays round number and buttons to add/rmv
  Widget toggleRoundBar()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ElevatedButton(
        //   onPressed: (){
        //     setState(() {widget.round!.addTimer();});
        //   },
        //   child: Text("+",
        //     style: TextStyle(
        //       fontWeight: FontWeight.normal,
        //       fontSize: 35
        //       ),
        //   )
        // ),
        Text(
          "round: ${widget.roundNum}",
          style: TextStyle(
            fontSize: 30, 
            fontWeight: FontWeight.bold
          ),
        ),
        if(widget.isDeletable)
            FilledButton.tonal(
              onPressed: () {
                if(widget.onRemove() != Null)
                {
                  widget.onRemove();
                }
              },
              child: Icon(Icons.highlight_remove),
            ),
        // ElevatedButton(
        //   onPressed: (){
        //     setState(() {
        //       widget.round!.removePhaseTimer();
        //     });
        //   },
        //   child: Text("-",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 35   
        //     ),
        //   )
        // ),
      ]
    ); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: toggleRoundBar()
            ),
            
            for(var timer in widget.round!.phaseTimers)
              PhaseCard(timer)
          ],
        ),
    );
  }
}

