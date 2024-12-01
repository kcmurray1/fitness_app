import 'package:fitness_app/utilities/round.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/utilities/interval_timer.dart';
import 'package:fitness_app/pages/timer_settings_page/widgets/round_card.dart';
import 'package:fitness_app/common/widgets/time_display.dart';

class TimerAdvancedSettings extends StatefulWidget {
    @override
    State<TimerAdvancedSettings> createState() => _TimerAdvancedSettingState();
}

class _TimerAdvancedSettingState extends State<TimerAdvancedSettings>
{  
    /// Display detailed controls for this [IntervalTimer] such as
    /// adding/removing [Rounds] and altering the their sets(currently called phaseTimers)
    Container buildDisplay(IntervalTimer intervalTimer, Color backgroundColor)
    {
        return Container(
          color: backgroundColor,
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: TextFormField(
                    maxLength: 20,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30
                    ),
                    initialValue: intervalTimer.name,
                    onChanged: (value){
                      intervalTimer.name = value; 
                  },
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [   
                  Text("Total Time: ${TimeDisplayField.timeDisplay(intervalTimer.totalTime)}",
                  style: TextStyle(fontSize: 30)),
                ],
              ),
              Flexible(
                  child: SizedBox(
                    width: 370,
                    child: Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 20,
                      interactive: true,
                      child: ListView.builder(
                        itemCount: intervalTimer.rounds.length,
                        itemBuilder:(context, index){ 
                          Round round = intervalTimer.rounds[index];
                            return RoundCard(
                              key: ValueKey(round),
                              round: round,
                              roundNum: index + 1,
                              onRemove: (){
                                intervalTimer.removeRound(round);
                              },  
                              onDuplicate: (){
                                intervalTimer.addRound(duplicateRound: round);
                              },
                            );
                        }

                      ),
                    ),
                )
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () => intervalTimer.addRound(),
                        child: Icon(Icons.add),
                      ),
                    ),  
                  ],
                ),
            ]
          )
        );
    }

    @override
    Widget build(BuildContext context)
    {
        var intervalTimer = context.watch<IntervalTimer>();
        intervalTimer.removeEmptyRounds();
        return buildDisplay(
          intervalTimer, 
          Theme.of(context).colorScheme.inversePrimary);
    }
}


