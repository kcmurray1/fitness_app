import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/pages/timer_page/widgets/time_display.dart';

class TimerSimpleSettings extends StatefulWidget
{
  @override
  State<TimerSimpleSettings> createState() => _TimerSimpleSettingState();
}

class _TimerSimpleSettingState extends State<TimerSimpleSettings>
{

  double _fontSize = 30;
  double _paddingBetweenItems = 15.0;

  Future<void> displayWarning(IntervalTimer timer, BuildContext context, {required Function onAccept})
  {
    if(!timer.isSimple)
    {
      timer.isSimple = true;
      return showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Warning: Override Changes")),
          content: Text("Using the Simple Editor overrides changes made by the Advanced Editor.\n"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: (){
                    Navigator.of(context).pop();
                }, child: Text("Cancel")),
                  
                TextButton(onPressed: (){
                    Navigator.of(context).pop();
                    onAccept();
                }, child: Text("Continue")),
              ],
            )
           
          ],
        )
      );
    }
    return Future((){});
  }

  Widget buildDisplay(IntervalTimer intervalTimer, BuildContext context)
  {
    return Column(
        children: [
           Text("Total Rounds",
            style: TextStyle(fontSize: _fontSize)),
            toggleRow(
              timer: intervalTimer,
              onRemove: (){
                setState(() {
                  intervalTimer.removeLastRound();  
                });
              }, 
              onAdd: (){
                
                // modeCheck(intervalTimer.isSimple, context);
                setState(() {
                  intervalTimer.addRound();
                });
              }, 
              child: Text("${intervalTimer.rounds.length}",
                style: TextStyle(fontSize: _fontSize)
              ),
            ),
            Padding(padding: EdgeInsets.all(_paddingBetweenItems)),
            Expanded(child: ListView(
              children: [ 
                  Column(
                    children: [
                      Text(
                      "Work",
                      style: TextStyle(fontSize: _fontSize)
                    ),
                    toggleRow(
                      timer: intervalTimer,
                      child: TimeDisplayField(
                        time: intervalTimer.rounds[0].phaseTimers[0].getWorkTime(),  
                        timeColor: Colors.black,
                        onTimeChanged:( (time) {
                          
                          // modeCheck(intervalTimer.isSimple, context);
                          setState((){intervalTimer.setAllRoundsWorkTime(time);});
                        })
                      ),
                      onAdd: (){
                        print("add");
                      },
                      onRemove: (){
                        print("remove");
                      }
                    ),
                    Padding(padding: EdgeInsets.all(_paddingBetweenItems)),
                    Text(
                      "Rest",
                      style: TextStyle(fontSize: _fontSize)
                    ),
                    toggleRow(
                        timer: intervalTimer,
                        onRemove: (){
                          print("minus 1 to rest");
                        }, 
                        onAdd: (){
                          print("plus 1 to rest");
                        }, 
                        child: TimeDisplayField(
                            time: intervalTimer.rounds[0].phaseTimers[0].getRestTime(),  
                            timeColor: Colors.black,
                            onTimeChanged:( (time) {
                              
                              // modeCheck(intervalTimer.isSimple, context);
                              setState((){intervalTimer.setAllRoundsWorkTime(time);});
                            })
                        ),
                      ),
                      Text(intervalTimer.id)
                      
                    ],
                  ),
              ],
            )
          ),
          Padding(padding: EdgeInsets.all(_paddingBetweenItems)),
          Text("Total time: ${timeDisplay(intervalTimer.getTotalTime())}",
          style: TextStyle(fontSize: _fontSize))
      
          ],
      );
  }
  
  /// Creates [Widget] with [ElevatedButton] on each side of the required child widget
  SizedBox toggleRow({
    double buttonSize = 45,
    double iconSize = 45,
    required Function onRemove,
    required Function onAdd,
    required Widget child,
    required IntervalTimer timer
  }) {
    return SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () async {
                  await displayWarning(timer, context, onAccept: ()=> onAdd());
              }, 
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(),
                minimumSize: Size(buttonSize, buttonSize)
              ),
              child: Icon(Icons.add_box_rounded,
                size: iconSize
              )),
              child,
              ElevatedButton(
                onPressed: () {
                  onRemove();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, 
                  shape: RoundedRectangleBorder(), 
                  minimumSize: Size(buttonSize, buttonSize),
                ),
                child: Icon(
                  Icons.indeterminate_check_box_rounded,
                  size: iconSize,
                ))
             ],
          ),
        );
  }

  @override
  Widget build(BuildContext context)
  {
    IntervalTimer intervalTimer = context.watch<IntervalTimer>();
  
  
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: buildDisplay(intervalTimer, context)
    );
  }
}


