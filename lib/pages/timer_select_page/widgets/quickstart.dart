
import 'package:fitness_app/common/config/timer_background.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/common/widgets/time_display.dart';
import 'package:provider/provider.dart';

import 'package:fitness_app/utilities/interval_timer.dart';
import 'package:fitness_app/utilities/json_storage.dart';
import 'package:fitness_app/pages/timer_page/timer_page.dart';

/// Direct method of using an [IntervalTimer].
class QuickStart extends StatefulWidget
{
  final JsonStorage storage;
  static String text = "QUICKSTART";
  int numRounds;
  Duration restTime;
  Duration workTime;
  final Color restColor;
  final Color workColor;

  QuickStart({super.key,
    required this.storage,
    this.numRounds = 99,
    this.restTime = const Duration(seconds: 30), 
    this.workTime = const Duration(seconds: 15),
    required this.restColor,
    required this.workColor
  });

  factory QuickStart.fromJson ({
    Key? key,
    required storage,
    required dynamic jsonData
  })
  {
    return QuickStart(
      key: key,
      storage: storage,
      numRounds: jsonData["numRounds"],
      workTime: Duration(seconds: jsonData["work"]),
      restTime: Duration(seconds: jsonData["rest"]),
      workColor: TimerBackgroundColors.lightBlue,
      restColor: TimerBackgroundColors.brightPurple,
      );
  }


  @override
  State<QuickStart> createState() => _QuickStartState();
}

class _QuickStartState extends State<QuickStart>
{
  String _storageId = "quickstart";

  void saveChanges()
  {
    widget.storage[_storageId] = toJson();
    widget.storage.save();
  }

  dynamic toJson()
  {
    return {"numRounds": widget.numRounds, "work": widget.workTime.inSeconds, "rest": widget.restTime.inSeconds};
  }
  @override
  Widget build(BuildContext context) {
    double textSize = 30;
    Color textColor = Theme.of(context).colorScheme.primary;
    TextStyle textStyle = TextStyle(fontSize: textSize, color: textColor, fontWeight: FontWeight.bold);
    return Container(
          color: Colors.white,
          child: ExpansionTile(
            title: Text("Quickstart", style: textStyle),
            children: [
                Column(
                  children: [
                    Text("rounds", style: textStyle),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: "${widget.numRounds}",
                        textAlign: TextAlign.center,
                        maxLength: 2,
                        style: TextStyle(fontSize: textSize),
                        onChanged: (value){
                          setState(() {
                            widget.numRounds = int.tryParse(value) ?? widget.numRounds;
                          });
                          saveChanges();
                        },
                      ),
                    ),
                    
                    Text("work",
                      style: textStyle,
                    ),
                    TimeDisplayField(time: widget.workTime, onTimeChanged: (newTime){
                      setState(() {
                        widget.workTime = newTime;  
                      });
                      saveChanges();
                      
                    } , timeColor: Colors.black),
                    Padding(padding: EdgeInsets.all(10)),
                    Text("rest",
                      style: textStyle,
                    ),
                    TimeDisplayField(time: widget.restTime, onTimeChanged: (newTime){
                      setState(() {
                        widget.restTime = newTime;
                      });
                      saveChanges();
                    } , timeColor: Colors.black),
                  ]
                ),  
                Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: ()=> {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => IntervalTimer(numRounds: widget.numRounds, workTime: widget.workTime, restTime: widget.restTime),
                          child: TimerPage(restColor: widget.restColor, workColor: widget.workColor),
                        )
                        ),
                      )
                    }, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.bolt, color: Colors.amber),
                      Text(QuickStart.text)
                    ]
                    )
                  ),
                )
              ],
      
          ),
        );
  }
}