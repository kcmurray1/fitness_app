import 'package:flutter/material.dart';

abstract class BaseIntervalTimer extends ChangeNotifier
{
  Duration defaultWorkTime;
  Duration defaultRestTime;

  void reset();
  void start();
  void stop();
  void update();
  dynamic toJson();

  BaseIntervalTimer({required this.defaultRestTime,required this.defaultWorkTime});

  
}