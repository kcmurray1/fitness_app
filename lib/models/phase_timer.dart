import 'package:flutter/material.dart';
import 'dart:async';
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
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
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
        duration -= const Duration(milliseconds: 100);
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

  // this method was supplied by ChatGPT
  String formatDuration() {
    // Extract components from the Duration object
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    int hundredths = (duration.inMilliseconds.remainder(1000) / 100).truncate();

    // Format as HH:MM:SS:XX (where XX is hundredths of a second)
    String formatted = 
        '${hours.toString().padLeft(1, '0')}:' // Hours (no padding for leading 0)
        '${minutes.toString().padLeft(2, '0')}:' // Minutes, padded to 2 digits
        '${seconds.toString().padLeft(2, '0')}.' // Seconds, padded to 2 digits
        '${hundredths.toString()}';

    return formatted;
  }

   String durationAsString(Duration duration) {
    // Extract components from the Duration object
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    int hundredths = (duration.inMilliseconds.remainder(1000) / 10).truncate();

    // Format as HH:MM:SS:XX (where XX is hundredths of a second)
    String formatted = 
        '${hours.toString().padLeft(1, '0')}:' // Hours (no padding for leading 0)
        '${minutes.toString().padLeft(2, '0')}:' // Minutes, padded to 2 digits
        '${seconds.toString().padLeft(2, '0')}.' // Seconds, padded to 2 digits
        '${hundredths.toString().padLeft(2, '0')}'; // Hundredths, padded to 2 digits

    return formatted;
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