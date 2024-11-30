import 'package:flutter/material.dart';
import 'package:fitness_app/utilities/round.dart';
import 'phase_card.dart';
import 'package:fitness_app/common/widgets/custom_pop_up_menu.dart';

/// Display [PhaseTimers] in this [Round] <br>
/// Provides functionality for adding and removing timers from this [Round]
class RoundCard extends StatefulWidget {
  final Round round;
  final int? roundNum;
  final Function onRemove;
  final Function onDuplicate;

  RoundCard({
    super.key,
    required this.round, 
    this.roundNum, 
    required this.onRemove,
    required this.onDuplicate
    });

  @override
  State<RoundCard> createState() => _RoundCardState();
}

class _RoundCardState extends State<RoundCard> {

  bool _isEditable = false;
  ExpansionTileController _expansionTileController = ExpansionTileController();

  // Displays round number and buttons to add/rmv
  Widget toggleRoundBar()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: (){
            setState(() {widget.round.addTimer();});
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
              widget.round.removePhaseTimer();
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
      controller: _expansionTileController,
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
      trailing: CustomPopUpMenu(
        onEdit: (){
          setState((){
            _isEditable = true;
          
          });
          if(!_expansionTileController.isExpanded)
          {
            _expansionTileController.expand();
          }
        },
        onDelete: () => widget.onRemove(),
        onDuplicate: () => widget.onDuplicate(),
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
                      itemCount: widget.round.phaseTimers.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            PhaseCard(timer: widget.round.phaseTimers[index]),
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

