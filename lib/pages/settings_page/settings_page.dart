

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget
{
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
{
  TextStyle textStyle = TextStyle(fontSize: 35);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(title: Text("Settings", style: TextStyle(fontSize: 50))),
          ListTile(title: Text("colors", style: textStyle)),
          
          ListTile(title: Text("work", style: textStyle)),
          
          ListTile(title: Text("rest", style: textStyle)),
        ],
      )); 
  }
}