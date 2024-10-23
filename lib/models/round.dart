import 'package:flutter/material.dart';
import 'phase_timer.dart';

class Round extends ChangeNotifier {
  // NOTE: maybe rename phaseTimers to sets?
  // store the phaseTimers
  List<PhaseTimer> phaseTimers = [];
  int _phaseTimerIndex = 0;
  bool isStarted = false;
  int _defaultSets = 2;
  Duration _defaultTimeOn = Duration(seconds: 5);
  Duration _defaultRest = Duration(seconds:  2);
  
  Round()
  {
    for(int i = 0; i < _defaultSets; i++)
    {
      addPhaseTimer(PhaseTimer(_defaultTimeOn, _defaultRest, i));
    }
  }
  void addTimer()
  {
    PhaseTimer newTimer = PhaseTimer(_defaultTimeOn, _defaultRest, phaseTimers.length);
    newTimer.addListener(update);
    phaseTimers.add(newTimer);
    notifyListeners();
  }
  void addPhaseTimer(PhaseTimer newTimer)
  {
    newTimer.addListener(update);
    phaseTimers.add(newTimer);

    notifyListeners();
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

  // Start the round
  void start()
  {
    print("starting round...");
    if(this.isRunning)
    {
      return;
    }
    isStarted = true;
    phaseTimers[_phaseTimerIndex].start();
    notifyListeners();
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
    // return phaseTimers[_phaseTimerIndex].durationAsString(phaseTimers[_phaseTimerIndex].getWorkTime());
  }

  bool _isValidTimerIndex()
  {
    return _phaseTimerIndex < phaseTimers.length - 1;
  }

  void update()
  {
    // Move to next timer
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

  @override
  String toString()
  {
    return "Round($phaseTimers)";
  }
}
