

import 'dart:convert';

import 'package:fitness_app/common/config/timer_background.dart';
import 'package:fitness_app/common/config/user_config.dart';
import 'package:fitness_app/pages/settings_page/widgets/color_selector.dart';
import 'package:fitness_app/utilities/color_utils.dart';
import 'package:fitness_app/utilities/json_storage.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget
{
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
{
  TextStyle textStyle = TextStyle(fontSize: 35);
  double colorWidgetSize = 50;
  double colorWidgetSpacing = 50;


   JsonStorage _configStorage =  JsonStorage(
    fileName: "user_config.json",
    defaultValue: {"work_color" : ColorUtils.serialize(TimerBackgroundColors.limeGreen), 
                   "rest_color": ColorUtils.serialize(TimerBackgroundColors.red)},
    defaultKey: "user"
  );

  dynamic presetData; 

   void _loadPresetData()
  {
    print("settings.loading");
    _configStorage.read().then((value){
      setState(() {
        presetData = value;
        print(presetData);
      }); 
    });
  }

  @override
  void initState()
  {
    super.initState();
    _loadPresetData();
    
  }

  @override
  void dispose()
  {
    _configStorage.save();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          
          ListTile(title: Text("Settings", style: TextStyle(fontSize: 50))),
          ListTile(title: Text("colors", style: textStyle)),
          if(presetData != null)
          ListTile(title: Text("work", style: textStyle),
          trailing: ColorSelector(initialColor: UserConfig.getWorkColor(presetData),
            onColorChange: (color){
              UserConfig.setWorkColor(presetData, color);
              _configStorage.save();
            }
          )
          ),
          if(presetData != null)
          ListTile(title: Text("rest", style: textStyle),
            trailing: ColorSelector(initialColor:  UserConfig.getRestColor(presetData),
            onColorChange: (color){
              UserConfig.setRestColor(presetData, color);
              setState(() {
                _configStorage.save();
              });
            },
            )
          ),
          ElevatedButton(
            onPressed: (){
              setState(() {
                _configStorage.clear();  
              });
            },
            child: Text("USE DEFAULT"),
          )
        ],
      )); 
  }
}