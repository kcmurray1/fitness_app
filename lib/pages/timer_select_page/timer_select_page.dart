import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
// Custom classes
import 'package:fitness_app/pages/timer_page/timer_page.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/pages/timer_settings_page/timer_settings_page.dart';
import 'package:fitness_app/models/json_storage.dart';

class TimerSelectPage extends StatefulWidget
{

  TimerSelectPage({
    super.key,
  });

  @override
  State<TimerSelectPage> createState() => _TimerSelectPageState();
}

class _TimerSelectPageState extends State<TimerSelectPage>
{
  JsonStorage _timerStorage =  JsonStorage(
    fileName: "user_timers.json",
    defaultValue: {"name": "default", "work": 60, "rest" : 30, "rounds" : 5}
  );

  dynamic presetData;

  Future<void> loadJsonAsset() async { 
    final String jsonString = await DefaultAssetBundle.of(context).loadString("assets/timer_presets.json"); 
    var data = json.decode(jsonString); 
    print(data);
    setState(() { 
      presetData = data; 
    });
  } 

  @override
  void initState()
  {
    super.initState();
    // loadJsonAsset();
   _timerStorage.read().then((value){
      setState(() {
        presetData = value;
      }); 
    });
  }

  
  
  Widget customCard({String? name, Duration work = const Duration(), Duration rest = const Duration(),
    int rounds = 99
  })
  {
    // total time is work + rest * number of rounds
    Duration totalTime = Duration(seconds: ((work + rest) * rounds).inSeconds);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.grey),
        color: Colors.white
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("$name",
                style: TextStyle(fontWeight: FontWeight.bold)
              ),
              Text(durationString(totalTime))
            ]
          ),
          Text("ROUNDS: $rounds"),
          Text("Work: ${durationString(work)}"),
          Text("Rest: ${durationString(rest)}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        IntervalTimer t = context.read<IntervalTimer>();
                        t.updateFromPreset(newRoundCount: rounds, newWorkTime: work, newRestTime: rest);
                        return TimerPage();
                      } 
                    ),
                  );

              }, label: Text("Start"), icon: Icon(Icons.play_arrow)),
              TextButton(onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        IntervalTimer t = context.read<IntervalTimer>();
                        t.updateFromPreset(newRoundCount: rounds, newWorkTime: work, newRestTime: rest);
                        return TimerSettingsPage();
                      } 
                    ),
                  );
              }, child: Icon(Icons.more_horiz))
            ],
          ),
        ],
      )
    );
  }

  /// Add default timer
  void _addTimer()
  {
    print("adding timer");
   _timerStorage[Uuid().v4()] = {"name": "default", "work": 3, "rest" : 1, "rounds" : 2};

    setState(() {
      presetData = _timerStorage.cache;
    }); 
  }

  void _clearData()
  {
     setState(() {
      presetData = _timerStorage.clear();
    });
  }

  String durationString(Duration duration)
  {
    String hours = duration.inHours.remainder(60).toString().padLeft(2, '0');
    
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  Widget _displayInfo()
  {
    if(presetData == null)
    {
      return Text("nop");
    }
    else
    {
      return ListView(
                  children:
                    presetData.entries.map<Widget>((entry){
                      String key = entry.key;
                      dynamic preset = entry.value;
                      return customCard(
                        name: preset["name"],
                        work: Duration(seconds: preset["work"]),
                        rest: Duration(seconds: preset["rest"]),
                        rounds: preset["rounds"]);
                    }).toList()
                );
    }
  }
  @override
  Widget build(BuildContext context)
  {
    print(presetData);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){}, child: Text("Quickstart")),
            
            Flexible(
              child: SizedBox(
                width: 400,
                child: _displayInfo()
              )
            )
            // Flexible(
            //   child: SizedBox(
            //     width: 400,
            //     child: ListView.builder(
            //       padding: EdgeInsets.all(5),
            //       itemCount: (presetData != null) ? presetData.length : 0,
            //       itemBuilder: (context, index){
            //         if(presetData == null)
            //         {
            //           return Text("nop");
            //         }
            //         var preset = presetData[index];
            //         return customCard(
            //           name: preset["name"],
            //           work: Duration(seconds: preset["work"] ?? -5),
            //           rest: Duration(seconds: preset["rest"] ?? -2),
            //           rounds: preset["rounds"]
            //         );
            //       },
                 
            //     ),
            //   ),
            // ),
            
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(onPressed: () {
        _addTimer();
      }, 
      child: Icon(Icons.add_a_photo)),
    );
  }

}
