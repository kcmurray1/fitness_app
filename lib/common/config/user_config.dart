import 'package:fitness_app/utilities/color_utils.dart';
import 'package:flutter/material.dart';
class UserConfig {

  static bool isValidKey(data, key)
  {
    return (data["user"] != null && data["user"][key] != null);
  }

  static dynamic getKey(dynamic data, String key, dynamic defaultVal) {
    // Return defaultValue if the key is invalid or 
    return isValidKey(data, key) ? data["user"][key] : defaultVal;
  }

  static updateKey(dynamic data, String key, Function onUpdate)
  {
    if(isValidKey(data, key))
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
    updateKey(storage, "rest_color", (){
      storage["user"]["rest_color"] = ColorUtils.serialize(color);
    });
  }

  
  static setWorkColor(dynamic storage, Color color)
  {
    updateKey(storage, "work_color", (){
      storage["user"]["work_color"] = ColorUtils.serialize(color);
    });
  }
}