import 'package:fitness_app/models/base_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Settings Widgets
import 'package:fitness_app/pages/timer_settings_page/widgets/timer_advanced_settings.dart';
import 'package:fitness_app/pages/timer_settings_page/widgets/timer_simple_settings.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/models/base_timer.dart';

class TimerSettingsPage extends StatefulWidget {
  final IntervalTimer? timer;
  // final BaseIntervalTimer? timer;

  TimerSettingsPage({
    super.key,
    this.timer,
  });
  

  @override
  State<TimerSettingsPage> createState() => _TimerSettingsPage();
}

class _TimerSettingsPage extends State<TimerSettingsPage> {
  // defualt to simple timer
  bool _isSimpleTimer = true;
  
  @override
  Widget build(BuildContext context) {
    Color selectedButtonColor = Theme.of(context).colorScheme.surface;
    Color unselectedButtonColor = Colors.grey;

    return Scaffold(
          appBar: AppBar(
            leading: TextButton(
              onPressed: (){
                Navigator.of(context).pop({"result": true, "save_data": true});
              },
              child: Icon(Icons.arrow_back, color: Colors.black)
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: 
              Row(
                children: [
                  OutlinedButton(
                    onPressed: (){
                      setState((){
                        _isSimpleTimer = true;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _isSimpleTimer ? selectedButtonColor : unselectedButtonColor
                      )
                    ),
                    child: Text(
                      "Simple",
                      style: TextStyle(
                      color: Theme.of(context).colorScheme.surface
                      )
                    )
                  ),
                  OutlinedButton(
                    onPressed: (){
                    setState(() {
                      _isSimpleTimer = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: _isSimpleTimer ? unselectedButtonColor : selectedButtonColor
                    )
                  ),
                  child: Text("Advanced",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface
                      )
                    )
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: CircleBorder()
                    ),
                    onPressed: (){}, 
                    child: Icon(Icons.help))
                ],
              )
          ),
          body: _isSimpleTimer ? TimerSimpleSettings() : TimerAdvancedSettings()
        );
  
  }
}
