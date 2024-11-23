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
import 'package:fitness_app/pages/timer_page/widgets/round_card_menu.dart';

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
    defaultValue: {"name": "default", "work": 60, "rest" : 30, "num_rounds" : 5}
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

  void _loadPresetData()
  {
    _timerStorage.read().then((value){
      print("read from file $value");
      setState(() {
        presetData = value;
      }); 
    });
  }

  @override
  void initState()
  {
    super.initState();
    // loadJsonAsset();
    _loadPresetData();
  }

  Widget customCard({String? name, Duration work = const Duration(), Duration rest = const Duration(),
    int rounds = 99, 
    required String id,
    required Function onDelete
  })
  {
    // total time is work + rest * number of rounds NOTE: this only applies to simple timers
    IntervalTimer timer = IntervalTimer(id: id, workTime: work, restTime: rest, numRounds: rounds); 
    Duration totalTime = timer.getTotalTime();
    // Duration totalTime = Duration(seconds: ((work + rest) * rounds).inSeconds);
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
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => IntervalTimer(id: id, workTime: work, restTime: rest, numRounds: rounds),
                        child: TimerPage(),
                      )
                    ),
                  );

              }, label: Text("Start"), icon: Icon(Icons.play_arrow)),
              RoundCardPopUpMenu(
                iconColor: Colors.blue,
                onDelete: onDelete,
                onEdit: () async {
                  IntervalTimer settingsTimer = IntervalTimer(id: id, workTime: work, restTime: rest, numRounds: rounds);
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => settingsTimer,
                        child: TimerSettingsPage(),
                      )
                    ),
                  ).then((onValue) {
                    if(onValue["save_data"])
                    {
                      // Update data
                      // setState(() {
                      //   _timerStorage[id] = settingsTimer.toJson();  
                      // });
                      print(settingsTimer.toJson());
                      // Reload data to show changes
                      _loadPresetData();
                      
                    }
                  });
                  
                },
                onDuplicate: (){}
              )
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
   _timerStorage[Uuid().v4()] = {"name": "default", "work": 3, "rest" : 1, "num_rounds" : 2};

    setState(() {
      presetData = _timerStorage.cache;
    }); 
    _timerStorage.save();
  }

  void _clearData()
  {
     setState(() {
      presetData = _timerStorage.clear();
    });
    _timerStorage.save();
  }

  void _removeData(dynamic id)
  {
    _timerStorage.remove(id);
    setState(() {
      presetData = _timerStorage.cache;
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
            String id = entry.key;
            dynamic preset = entry.value;
            return customCard(
              name:"no_name",
              id: id,
              work: Duration(seconds: preset["work"]),
              rest: Duration(seconds: preset["rest"]),
              rounds: preset["num_rounds"],
              onDelete: ()=> _removeData(id),
              );
          }).toList()
      );
    }
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Quickstart")),
                ElevatedButton(onPressed: _clearData, child: Icon(Icons.clear_all_outlined))
              ],
            ),
            
            Flexible(
              child: SizedBox(
                width: 400,
                child: _displayInfo()
              )
            )    
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(onPressed: () {
        _addTimer();
      }, 
      child: Icon(Icons.add_alarm)),
    );
  }

}
