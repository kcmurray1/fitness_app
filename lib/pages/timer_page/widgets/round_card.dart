import 'package:flutter/material.dart';
import 'package:fitness_app/models/round.dart';
import 'phase_card.dart';
import 'round_card_menu.dart';

/// Display [PhaseTimers] in this [Round] <br>
/// Provides functionality for adding and removing timers from this [Round]
class RoundCard extends StatefulWidget {
  final Round? round;
  final int? roundNum;
  final Function onRemove;
  // final bool isDeletable;
  RoundCard({
    super.key,
    this.round, 
    this.roundNum, 
    // required this.isDeletable, 
    required this.onRemove
    });

  @override
  State<RoundCard> createState() => _RoundCard();
}

class _RoundCard extends State<RoundCard> {

  bool _isEditable = false;

  // Displays round number and buttons to add/rmv
  Widget toggleRoundBar()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: (){
            setState(() {widget.round!.addTimer();});
          },
          child: Icon(Icons.add)
        ),
        FilledButton.tonal(
          onPressed: () {
            setState((){
              _isEditable = false;
            });
          },
          child: Icon(Icons.edit_off),
        ),
        ElevatedButton(
          onPressed: (){
            setState(() {
              widget.round!.removePhaseTimer();
            });
          },
          child: Icon(Icons.remove)
        ),
      ]
    ); 
  }
 
 
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          Text(
              "Round: ${widget.roundNum}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30, 
                // fontWeight: FontWeight.bold
              ),
          ),
        ],
      ),
      trailing: RoundCardPopUpMenu(
        onEdit: (){
          setState((){
            _isEditable = true;
          });
        },
        onDelete: (){
          widget.onRemove();
        },

      ),
      collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(150),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            )
          ),
          child: 
              Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: widget.round!.phaseTimers.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            PhaseCard(timer: widget.round!.phaseTimers[index]),
                          ],
                        );
                      },
                    ),
                  ),
                  if(_isEditable)
                    toggleRoundBar()
                ],
              ),
        ),
      ],
    );

  }
}

