import 'package:fitness_app/utilities/color_utils.dart';
import 'package:flutter/material.dart';

/// Access User Configuration data 
class UserConfig {

  static bool _isValidKey(data, key)
  {
    return (data["user"] != null && data["user"][key] != null);
  }

  static dynamic getKey(dynamic data, String key, dynamic defaultVal) {
    // Return defaultValue if the key is invalid 
    return _isValidKey(data, key) ? data["user"][key] : defaultVal;
  }

  /// Perform action [onUpdate] on the value of [data] at a given [key]
  static _updateKey(dynamic data, String key, Function onUpdate)
  {
    if(_isValidKey(data, key))
    {
      onUpdate();
    }
  }

  static Color getWorkColor(dynamic storage){
    var res = getKey(storage, "work_color", Colors.green);
    if(res is String)
    {
      res = Color(int.parse(res));
    }
    return res;
  }

  static Color getRestColor(dynamic storage)
  {
    var res = getKey(storage, "rest_color", Colors.red);
    if(res is String)
    {
      res = Color(int.parse(res));
    }
    return res;
  }

  static setRestColor(dynamic storage, Color color)
  {
    _updateKey(storage, "rest_color", (){
      storage["user"]["rest_color"] = ColorUtils.serialize(color);
    });
  }

  
  static setWorkColor(dynamic storage, Color color)
  {
    _updateKey(storage, "work_color", (){
      storage["user"]["work_color"] = ColorUtils.serialize(color);
    });
  }
}