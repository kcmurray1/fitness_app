import 'dart:convert';

import 'package:flutter/material.dart';
import 'phase_timer.dart';
import 'round.dart';

/// Creates a
/// 
/// awd 
class IntervalTimer extends ChangeNotifier {
  int _totalRounds = 1;
  int round = 1;
  List<PhaseTimer> phaseTimers = [];
  bool isStarted = false;
  int _roundIndex = 0;
  List<Round> rounds = [];
  int _minimumTotalRounds = 1;

  String id;

  IntervalTimer({
    Duration workTime = const Duration(seconds: 5), 
    Duration restTime = const Duration(seconds:  2), 
    int numRounds = 2,
    this.id = "temp"
  })
  {
    for(int i = 0; i < numRounds; i++)
    {
      addRound(workTime: workTime, restTime: restTime);
    }
    _totalRounds = numRounds;
  }
  
  void updateFromPreset({
    required int newRoundCount,
    required Duration newWorkTime,
    required Duration newRestTime,
    required String id,
  })
  {
    // remove listeners
    for(Round round in rounds)
    {
      round.removeListener(update);
    }

    // rebuild rounds
    rounds.clear();
    for(int i = 0; i < newRoundCount; i++)
    {
      addRound(workTime: newWorkTime, restTime: newRestTime);
    }
    this.id = id;
    _totalRounds = newRoundCount;
  }
  /// Add a [Round] to this [IntervalTimer] with an optional [workTime] and [restTime]
  /// This will duplicate and add [Round] passed, otherwise creates a new [Round] 
  void addRound({
    Duration workTime = const Duration(seconds: 5),
    Duration restTime = const Duration (seconds: 2),
    Round? duplicateRound
  })
  {
    Round newRound;
    if(duplicateRound != null)
    {
      newRound = duplicateRound;
    }
    else
    {
      newRound = Round(initWorkTime: workTime, initRestTime: restTime);
      newRound.addListener(update);
    }
    
    rounds.add(newRound);
    _totalRounds++;
    // notifyListeners();
  }

  void removeRound(Round round)
  {
    if(_totalRounds == _minimumTotalRounds)
    {
      return;
    }
    rounds.remove(round);
    notifyListeners();
  }

  void removeLastRound()
  {
    if(rounds.length == _minimumTotalRounds)
    {
      return;
    }
    rounds.removeLast();
  }

  void removeEmptyRounds()
  {
    rounds.removeWhere((round) => round.isEmpty());
    _totalRounds = rounds.length;

  }

  void setAllRoundsWorkTime(Duration newTime)
  {
    for(Round round in rounds)
    {
      round.setAllWorkTime(newTime);
    }
  }

  void setAllRoundsRestTime(Duration newTime)
  {
    for(Round round in rounds)
    {
      round.setAllRestTime(newTime);
    }
    
  }

  Duration getTotalTime()
  {
    Duration totalTime = Duration();
    for(Round round in rounds)
    {
      for(PhaseTimer timer in round.phaseTimers)
      {
        totalTime += timer.getWorkTime() + timer.getRestTime();
      }
      
    }
    return totalTime;
  }
  // Start the current round
  void startRound()
  {
    if(isRunning())
    {
      return;
    }
    isStarted = true;
    rounds[_roundIndex].start();
  }

  Round get getCurrentRound
  {
    return rounds[_roundIndex];
  }
  /// Returns the place in the current [Round] in the format Completed/Remaining
  /// A [Round] with three [PhaseTimer] will start at 1/3 then update to 2/3...3/3  
  String get getRoundProgress
  {
    return rounds[_roundIndex].progress;
  }

  String getCurrentTime()
  {
    return rounds[_roundIndex].currentTime;
  }

  bool _isValidTimerIndex()
  {
    return _roundIndex < rounds.length - 1;
  }

  //Update the display
  void update()
  {
    // Move to next round
    if(_isValidTimerIndex() && rounds[_roundIndex].isRoundComplete)
    {
      rounds[_roundIndex].stop();
      _roundIndex++;
      round++;      
      startRound();
    }
    notifyListeners();
  }

  // Reset entire IntervalTimer
  void _reset()
  {
    _roundIndex = 0;
    round = 1;
    isStarted = false;
    // Reset all timers
    for(int i = 0; i < rounds.length; i++)
    {
      rounds[i].stop();
    }
  }

  // Stop the current Round or reset the entire IntervalTimer
  void stop({bool reset = true})
  {
    if(reset)
    {
      _reset();
    }
    rounds[_roundIndex].stop(reset: reset);
    notifyListeners();
  }

  bool isRunning()
  {  
    return rounds[_roundIndex].isRunning;
  }

  bool isComplete()
  {
    return round == _totalRounds && rounds[_roundIndex].isRoundComplete;
  }

  dynamic toJson()
  {
    dynamic roundData = {};
    for(int i = 0; i < rounds.length; i++)
    {
      roundData["round_$i"] = rounds[i].toJson();
    }
    return jsonEncode({"id": id, "num_rounds": _totalRounds, "rounds" : roundData});
  }
}



