

import 'package:fitness_app/pages/settings_page/widgets/color_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget
{
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
{
  TextStyle textStyle = TextStyle(fontSize: 35);

  Future<void> loadJsonAsset() async { 
    final String jsonString = await DefaultAssetBundle.of(context).loadString("assets/timer_presets.json"); 
    var data = json.decode(jsonString); 

    print(data);
   
  } 

  @override
  void initState()
  {
    super.initState();
    loadJsonAsset();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(title: Text("Settings", style: TextStyle(fontSize: 50))),
          ListTile(title: Text("colors", style: textStyle)),
          
          ListTile(title: Text("work", style: textStyle)),
          
          ListTile(title: Text("rest", style: textStyle)),
          ColorPaletteWidget()
        ],
      )); 
  }
}