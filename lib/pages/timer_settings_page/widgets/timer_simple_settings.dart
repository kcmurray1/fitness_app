import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/utilities/interval_timer.dart';
import 'package:fitness_app/common/widgets/time_display.dart';

class TimerSimpleSettings extends StatefulWidget
{
  @override
  State<TimerSimpleSettings> createState() => _TimerSimpleSettingState();
}

class _TimerSimpleSettingState extends State<TimerSimpleSettings>
{

  double _fontSize = 30;
  double _paddingBetweenItems = 15.0;
  bool ackWarning = false;


  void idk(IntervalTimer timer, BuildContext context, {required onAccept}) async
  {
    await displayWarning(timer, context)
      .then((onValue){
        print(onValue);
        if(onValue)
        {
          timer.simplify();
          onAccept();
        }
      });
  }

  bool _ignoreWarning()
  {
    return ackWarning == true;
  }
  

  Future<dynamic> displayWarning(IntervalTimer timer, BuildContext context)
  {
    if(!ackWarning)
    {
      return showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Warning: Override Changes")),
          content: Text("Using the Simple Editor may override changes made with the Advanced Editor.\n", style: TextStyle(fontSize: 20)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: (){
                    Navigator.of(context).pop(false);
                }, child: Text("Cancel")),
                  
                TextButton(onPressed: (){
                    Navigator.of(context).pop(true);
                    ackWarning = true;
                }, child: Text("Continue")),
              ],
            )
           
          ],
        )
      );
    }
    return Future(() => _ignoreWarning());
  }

  Widget buildDisplay(IntervalTimer intervalTimer, BuildContext context)
  {
    return Column(
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
             ),
           ),
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
                          // intervalTimer.simplify();
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
                              setState((){intervalTimer.setAllRoundsRestTime(time);});
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
          Text("Total time: ${TimeDisplayField.timeDisplay(intervalTimer.totalTime)}",
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
              ElevatedButton(onPressed: ()=> idk(timer, context, onAccept: ()=> onAdd()), 
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(),
                minimumSize: Size(buttonSize, buttonSize)
              ),
              child: Icon(Icons.add_box_rounded,
                size: iconSize
              )),
              child,
              ElevatedButton(onPressed: ()=> idk(timer, context, onAccept: ()=> onRemove()), 
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


