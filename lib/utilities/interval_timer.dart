import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'phase_timer.dart';
import 'round.dart';

/// Creates a
/// 
/// awd 
class IntervalTimer extends ChangeNotifier {
  int _totalRounds = 0;
  int round = 1;
  List<PhaseTimer> phaseTimers = [];
  bool isStarted = false;
  int _roundIndex = 0;
  List<Round> rounds = [];
  int _minimumTotalRounds = 1;
  bool isSimple = false;
  Duration avgWorkTime = Duration();
  Duration avgRestTime = Duration();

  String id;
  String name;

  IntervalTimer({
    Duration workTime = const Duration(seconds: 5), 
    Duration restTime = const Duration(seconds:  2), 
    int numRounds = 2,
    this.id = "temp",
    this.name = "no_name",
    bool createEmpty = false
  })
  {
    if(createEmpty)
    {
      return;
    }
    for(int i = 0; i < numRounds; i++)
    {
      addRound(workTime: workTime, restTime: restTime);
    }
    _totalRounds = numRounds;
  }


  factory IntervalTimer.fromJson({
    Key? key,
    String id = "missing_id",
    required dynamic jsonData,
  }){
    if(jsonData["name"] == null)
    {
      return IntervalTimer();
    }
    IntervalTimer newTimer = IntervalTimer(
       name: jsonData["name"],
      id: id,
      numRounds: jsonData["num_rounds"],
      workTime: Duration(seconds: jsonData["work"] ?? 10),
      restTime: Duration(seconds: jsonData["rest"] ?? 5),
      createEmpty: true
    );

    if(jsonData["rounds"] != null)
    {
      jsonData["rounds"].entries.map((round) {
        newTimer.addRound(duplicateRound: Round.fromList(data: round.value));
      }).toList();
    }

    return newTimer;

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
    }
    newRound.addListener(update);
    rounds.add(newRound);
    _totalRounds++;
    notifyListeners();
  }

  /// Removes specified [round]. <br> 
  /// Does nothing if the [_totalRounds] are equal to [_minimumTotalRounds]. <br>
  /// [_minimumtotalRounds] = 1 by default
  void removeRound(Round round)
  {
    if(_totalRounds == _minimumTotalRounds)
    {
      return;
    }
    rounds.remove(round);
    notifyListeners();
  }

  /// Removes last [round]. <br> 
  /// Does nothing if the [_totalRounds] are equal to [_minimumTotalRounds]. <br>
  /// [_minimumtotalRounds] = 1 by default
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

  bool isSingleRound()
  {
    return rounds[_roundIndex].phaseTimers.length == 1;
  }

  int get totalRounds
  {
    return _totalRounds;
  }

  Duration get totalTime
  {
    Duration totalTime = Duration();
    Duration totalRoundRest = Duration();
    Duration totalRoundWork = Duration();
    int totalSets = 0;
    for(Round round in rounds)
    {

      for(PhaseTimer timer in round.phaseTimers)
      {
        totalTime += timer.getWorkTime() + timer.getRestTime();
        totalRoundRest += timer.getRestTime();
        totalRoundWork += timer.getWorkTime();
      }
      totalSets += round.phaseTimers.length;
    }
    avgRestTime = Duration(seconds: totalRoundRest.inSeconds ~/ totalSets); 
    avgWorkTime = Duration(seconds: totalRoundWork.inSeconds ~/ totalSets);
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
    notifyListeners();
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
    rounds[_roundIndex].stop(resetRound: reset);
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

  /// Sets all Rounds to contain a single Phasetimer with uniform
  /// Work and Rest times <br>
  void simplify()
  {
    for(Round round in rounds)
    {
      round.phaseTimers = [round.phaseTimers[0]];
    }
    notifyListeners();
  }

  dynamic toJson()
  {
    dynamic roundData = {};
    for(int i = 0; i < rounds.length; i++)
    {
      roundData["round_${i+1}"] = rounds[i].toJson();
    }
    return {"id": id, "name": name, "timer_type": isSimple ? "simple" : "advanced", "num_rounds": _totalRounds, "rounds" : roundData};
  }
}



