import 'package:flutter/material.dart';
import 'phase_timer.dart';

class Round extends ChangeNotifier {
  // NOTE: maybe rename phaseTimers to sets?
  // store the phaseTimers
  List<PhaseTimer> phaseTimers = [];
  int _phaseTimerIndex = 0;
  bool isStarted = false;
  int _defaultSets = 2;
  final Duration initWorkTime;
  final Duration initRestTime;
  
  Round({
    this.initWorkTime = const Duration(seconds: -5),
    this.initRestTime = const Duration(seconds:  -2)
  })
  {
    for(int i = 0; i < _defaultSets; i++)
    {
      addTimer();
    }
  }

  String get progress
  {
    return "${_phaseTimerIndex + 1}/${phaseTimers.length}";
  }
  String get currentTime
  {
    if(isEmpty())
    {
      return "Nothing";  
    }
    return phaseTimers[_phaseTimerIndex].formatDuration();
  }

  // Check if current PhaseTimer is running
  bool get isRunning
  {
    return phaseTimers[_phaseTimerIndex].isRunning;
  }

  // Round is compelete whn all timers have been completed 
  bool get isRoundComplete
  {
    return _phaseTimerIndex == phaseTimers.length - 1 && phaseTimers[_phaseTimerIndex].isComplete();
  }

  void addTimer()
  {
    PhaseTimer newTimer = PhaseTimer(timeOn: initWorkTime, timeOff: initRestTime);
    newTimer.addListener(update);
    phaseTimers.add(newTimer);
    notifyListeners();
  }

  void setAllWorkTime(Duration newTime)
  {
    for(PhaseTimer timer in phaseTimers)
    {
      timer.setWorkTime(newTime);
    }
  }

  void setAllRestTime(Duration newTime)
  {
    for(PhaseTimer timer in phaseTimers)
    {
      timer.setRestTime(newTime);
    }
  }

  bool isEmpty()
  {
    return phaseTimers != Null && phaseTimers.isEmpty;
  }

  void removePhaseTimer({int index = 0})
  {
    if (isEmpty())
    {
      return;
    }
    phaseTimers.removeAt(index);
    notifyListeners();
  }

  /// Start the PhaseTimer at the current [_phaseTimerIndex]
  void start()
  {
    if(isRunning)
    {
      return;
    }
    isStarted = true;
    phaseTimers[_phaseTimerIndex].start();
    notifyListeners();
  }
 
  bool _isValidTimerIndex()
  {
    return _phaseTimerIndex < phaseTimers.length - 1;
  }

  /// This method listens for changes in the current [PhaseTimer]
  /// based on the state of the current [PhaseTimer] the round will sequentially
  /// move to the next [PhaseTimer] until they have all completed
  void update()
  {
    // Attempt to move to the next PhaseTimer in this round 
    if(_isValidTimerIndex() && phaseTimers[_phaseTimerIndex].isComplete())
    {
      phaseTimers[_phaseTimerIndex].stop();
      _phaseTimerIndex++;
      isStarted = false;
      start();
    }
    notifyListeners();
  }

  // Reset entire IntervalTimer
  void _reset()
  {
    _phaseTimerIndex = 0;
    isStarted = false;
    // Reset all timers
    for(int i = 0; i < phaseTimers.length; i++)
    {
      phaseTimers[i].stop();
    }
  }

  // Stop the current PhaseTimer or reset the entire Round
  void stop({bool reset = true})
  {
    if(reset)
    {
      _reset();
    }
    phaseTimers[_phaseTimerIndex].stop(reset: reset);
    notifyListeners();
  }

  @override
  String toString()
  {
    return "Round($phaseTimers)";
  }
}
