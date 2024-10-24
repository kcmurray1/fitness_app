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

  IntervalTimer(Duration workTime, Duration restTime, {int numRounds = 2})
  {
    for(int i = 0; i < numRounds; i++)
    {
      addRound();
    }
     _totalRounds = numRounds;
  }
  
  void addRound()
  {
    Round newRound = Round();
    newRound.addListener(update);
    rounds.add(newRound);
    _totalRounds++;
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


  void removeEmptyRounds()
  {
    rounds.removeWhere((round) => round.isEmpty());
    _totalRounds = rounds.length;

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

  String getRoundProgress()
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
}



