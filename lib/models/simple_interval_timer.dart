import 'base_timer.dart';
import 'phase_timer.dart';
import 'round.dart';

class SimpleIntervalTimer extends BaseIntervalTimer {
  
  late Round sets;
  final Duration initWorkTime;
  final Duration initRestTime;
  
  SimpleIntervalTimer({
    this.initWorkTime = const Duration(seconds: -5),
    this.initRestTime = const Duration(seconds:  -2),
  }) : super(defaultRestTime: initRestTime, defaultWorkTime: initWorkTime)
  {
    
    sets = Round(initRestTime: initRestTime, initWorkTime: initWorkTime);
  }
  
  bool get isWorkPhase
  {
    
    return sets.isWorkPhase;
  }

  String get progress
  {
    return sets.progress;
  }
  String get currentTime
  {
    return sets.currentTime;
  }

  // Check if current PhaseTimer is running
  bool get isRunning
  {
    return sets.isRunning;
  }

  // Round is compelete whn all timers have been completed 
  bool get isRoundComplete
  {
    return sets.isRoundComplete;
  }

  void addTimer()
  {
    sets.addTimer();
  }

  void setAllWorkTime(Duration newTime)
  {
    sets.setAllWorkTime(newTime);
  }

  void setAllRestTime(Duration newTime)
  {
    sets.setAllRestTime(newTime);
  }

  bool isEmpty()
  {
    return sets.isEmpty();
  }

  void removePhaseTimer({int index = 0})
  {
    sets.removePhaseTimer(index: index);
  }

  /// Start the PhaseTimer at the current [_phaseTimerIndex]
  @override
  void start()
  {
    sets.start();
  }
 
  bool isValidTimerIndex()
  {
    return sets.isValidTimerIndex();
  }

  /// This method listens for changes in the current [PhaseTimer]
  /// based on the state of the current [PhaseTimer] the round will sequentially
  /// move to the next [PhaseTimer] until they have all completed
  @override
  void update()
  {
    sets.update();
  }

  // Reset entire IntervalTimer
  @override
  void reset()
  {
    sets.reset();
  }

  // Stop the current PhaseTimer or reset the entire Round
  @override
  void stop({bool resetTimer = true})
  {
    sets.stop(resetRound: resetTimer);
  }

  @override
  String toString()
  {
    return "SimpleIntervalTimer";
  }
  
  @override
  dynamic toJson()
  {
    return sets.toJson();
  }
}
