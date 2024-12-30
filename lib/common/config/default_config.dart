import "package:fitness_app/utilities/color_utils.dart";
import "timer_background.dart";


/// Default values used when no user app data is present
class DefaultConfig {
  
  /// Background Colors for Work and Rest phase for all interval timers 
  static dynamic defaultBackground =
  {"work_color" : ColorUtils.serialize(TimerBackgroundColors.limeGreen), 
   "rest_color": ColorUtils.serialize(TimerBackgroundColors.red)};

  static dynamic defaultTimer = 
  {"name": "default", "timer_type": "simple", "num_rounds" : 5, 
   "rounds": {"round_0" : [{"work": 60, "rest": 30}]}};

  /// A timer named 'new_timer' containing 3 rounds of 60 second work and 30 second rest
  static dynamic defaultAddTimer =  
  {"name": "new_timer", "timer_type": "simple", "num_rounds" : 3, 
   "rounds": {"round_0" : [{"work": 60, "rest": 30}], 
              "round_1" : [{"work": 60, "rest": 30}], 
              "round_2" : [{"work": 60, "rest": 30}],
   }};

}