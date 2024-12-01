import 'package:flutter/material.dart';
// Settings Widgets
import 'package:fitness_app/pages/timer_settings_page/widgets/timer_advanced_settings.dart';
import 'package:fitness_app/pages/timer_settings_page/widgets/timer_simple_settings.dart';
import 'package:fitness_app/utilities/interval_timer.dart';
import 'widgets/timer_help.dart';

class TimerSettingsPage extends StatefulWidget {
  final IntervalTimer? timer;

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
    //https://stackoverflow.com/questions/50452710/catch-android-back-button-event-on-flutter
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(!didPop)
        {
            Navigator.of(context).pop({"result" : true, "save_data" : true});
        }
      },
      child: Scaffold(
            appBar: AppBar(
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
                    Spacer(),
                    TimerHelp()
                  ],
                )
            ),
            body: _isSimpleTimer ? TimerSimpleSettings() : TimerAdvancedSettings()
          )
    ); 
  }
}
