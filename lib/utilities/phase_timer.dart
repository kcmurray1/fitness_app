import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fitness_app/common/widgets/time_display.dart';

// Individual timer used for each phase (work: rest) during an interval
class PhaseTimer extends ChangeNotifier {
  Duration initialDuration = Duration();
  bool isRunning = false;
  Timer? _timer;
  Duration duration = Duration();
  Duration _restTime = Duration();
  Duration _workTime = Duration();
  bool _isWorkPhase = true;

  PhaseTimer({
    Duration timeOn = const Duration(seconds: 10),
    Duration timeOff = const Duration(seconds: 5)
  })
  {
    setWorkTime(timeOn);
    setRestTime(timeOff);
    // Initially set the clock to use the work time
    setDuration(timeOn);
  }

  bool get isWorkPhase
  {
    return _isWorkPhase;
  }
  // The PhaseTimer is marked as complete after the
  // the work duration and rest duration have completed
  bool isComplete()
  {
    return duration == Duration() && !_isWorkPhase;
  }

  Duration getWorkTime()
  {
    return _workTime;
  }

  set workTime(Duration val)
  {
    _workTime = val;
  }
  Duration getRestTime()
  {
    return _restTime;
  }

  void setWorkTime(Duration newTime)
  {
    _workTime = newTime;
    setDuration(_workTime);
    notifyListeners();
  }

  void setRestTime(Duration newTime)
  {
    _restTime = newTime;
    notifyListeners();
  }
  void setDuration(Duration newDuration)
  {
    duration = newDuration;
    initialDuration = duration;
  }

  void reset()
  {
    setDuration(_workTime);
    _isWorkPhase = true;
    duration = initialDuration;
    isRunning = false;
  }

  void _switchPhase() async
  {
    _isWorkPhase = false;
    setDuration(_restTime);
    notifyListeners();
    
  }
  // Start the timer
  void start()
  {
    print("starting phaseTimer...");
    if(isRunning)
    {
      return;
    }

    isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(duration.inMicroseconds == 0)
      {
        if(_isWorkPhase)
        {
          _switchPhase();
        }
        else
        {
          stop(reset: false);
        }
        
      }
      else
      {
        duration -= const Duration(seconds: 1);
      }
      notifyListeners();
      
    });
  }
  
  void stop({bool reset = true})
  {
    if (reset)
    {
      this.reset();
    }
    isRunning = false;
    if(_timer != null)
    {
      _timer!.cancel();
    }
    
    notifyListeners();
  }

  String formatDuration() {
    return TimeDisplayField.timeDisplay(duration);
  }

  @override
  String toString()
  {
    return "PhaseTimer(Work: ${_workTime} seconds, Rest: ${_restTime})";
  }

  dynamic toJson()
  {
    return {"work": _workTime.inSeconds, "rest": _restTime.inSeconds};
  }
}