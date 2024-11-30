import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
// pages
import 'package:fitness_app/pages/timer_page/timer_page.dart';
import 'package:fitness_app/pages/timer_settings_page/timer_settings_page.dart';
// utilities
import 'package:fitness_app/utilities/interval_timer.dart';
import 'package:fitness_app/utilities/json_storage.dart';
// common
import 'package:fitness_app/common/widgets/custom_pop_up_menu.dart';

// widgets
import 'widgets/quickstart.dart';

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
    defaultValue: {"name": "default", "timer_type": "simple", "num_rounds" : 5, "rounds": {"round_0" : [{"work": 60, "rest": 30}]}}
  );

  dynamic presetData;


  Future<void> loadJsonAsset() async { 
    final String jsonString = await DefaultAssetBundle.of(context).loadString("assets/timer_presets.json"); 
    var data = json.decode(jsonString); 
    setState(() { 
      presetData = data; 
    });
  } 

  void _loadPresetData()
  {
    _timerStorage.read().then((value){
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

  @override
  void dispose()
  {
    super.dispose();
  }

  
  Widget customCard ({
    required IntervalTimer timer,
    required Function onDelete
  })
  {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.grey),
        color: Colors.white
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(timer.name,
                style: TextStyle(fontWeight: FontWeight.bold)
              ),
              Center(child: Text(durationString(timer.totalTime))),
              CustomPopUpMenu(
                iconColor: Colors.blue,
                onDelete: onDelete,
                onEdit: () async {
                  IntervalTimer settingsTimer = timer;
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
                      setState(() {
                        _timerStorage[timer.id] = settingsTimer.toJson();  
                      });
                      
                      _timerStorage.save();
                      // Reload data to show changes
                      _loadPresetData();
                      
                    }
                  });
                  
                },
                onDuplicate: (){}
              )
            ]
          ),
          Text("ROUNDS: ${timer.totalRounds}"),
          Text("AVG WORK: ${durationString(timer.avgWorkTime)}"),
          Text("AVG REST: ${durationString(timer.avgRestTime)}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => IntervalTimer.fromJson(jsonData: timer.toJson()),
                        child: TimerPage(),
                      )
                    ),
                  );

              }, label: Text("Start"), icon: Icon(Icons.play_arrow)),
              
            ],
          ),
        ],
      )
    );
  }

  /// Add default timer
  void _addTimer()
  {
   _timerStorage[Uuid().v4()] = {"name": "new_timer", "timer_type": "simple", "num_rounds" : 3, "rounds": {"round_0" : [{"work": 60, "rest": 30}], 
    "round_1" : [{"work": 60, "rest": 30}], "round_2" : [{"work": 60, "rest": 30}],
   }};

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
      return Text("Loading data...");
    }
    else
    {
      return ListView(
        children:
          presetData.entries.map<Widget>((entry){

            String id = entry.key;
            dynamic preset = entry.value;
            return customCard(timer: IntervalTimer.fromJson(
                id: id,
                jsonData: preset
              ), 
              onDelete: () => _removeData(id),
            );
            //   );
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
                QuickStart(onPressed: (){}),
                // ElevatedButton(onPressed: (){}, child: Text("Quickstart")),
                // ElevatedButton(onPressed: _clearData, child: Icon(Icons.clear_all_outlined))
              ],
            ),
            Flexible(
              child: SizedBox(
                width: 400,
                child: _displayInfo()
              )
            ),
            // ElevatedButton(onPressed: () async{          
                    
                      
                
            // }, child: Icon(Icons.audiotrack))    
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _addTimer();
      }, 
      child: Icon(Icons.add_alarm)),
    );
  }

}
