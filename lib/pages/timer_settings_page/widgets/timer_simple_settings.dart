import 'package:fitness_app/models/base_timer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/pages/timer_page/widgets/time_display.dart';
import 'package:fitness_app/models/complex_interval_timer.dart';

class TimerSimpleSettings extends StatefulWidget
{
  @override
  State<TimerSimpleSettings> createState() => _TimerSimpleSettingState();
}

class _TimerSimpleSettingState extends State<TimerSimpleSettings>
{

  double _fontSize = 30;
  double _paddingBetweenItems = 15.0;

  Widget buildDisplay(IntervalTimer intervalTimer)
  {
    return Column(
        children: [
           Text("Total Rounds",
            style: TextStyle(fontSize: _fontSize)),
            toggleRow(
              onRemove: (){
                setState(() {
                  intervalTimer.removeLastRound();
                });
              }, 
              onAdd: (){
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
                    child: TimeDisplayField(
                      time: intervalTimer.rounds[0].phaseTimers[0].getWorkTime(),  
                      timeColor: Colors.black,
                      onTimeChanged:( (time) {
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
  }) {
    return SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: (){
                  onAdd();
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
      child: buildDisplay(intervalTimer)
    );
  }
}