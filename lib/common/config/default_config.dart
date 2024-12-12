import "package:fitness_app/utilities/color_utils.dart";
import "timer_background.dart";
class DefaultConfig {
  static dynamic defaultBackground =
  {"work_color" : ColorUtils.serialize(TimerBackgroundColors.limeGreen), 
   "rest_color": ColorUtils.serialize(TimerBackgroundColors.red)};

  static dynamic defaultTimer = 
  {"name": "default", "timer_type": "simple", "num_rounds" : 5, 
   "rounds": {"round_0" : [{"work": 60, "rest": 30}]}};

  static dynamic defaultAddTimer =  
  {"name": "new_timer", "timer_type": "simple", "num_rounds" : 3, 
   "rounds": {"round_0" : [{"work": 60, "rest": 30}], 
              "round_1" : [{"work": 60, "rest": 30}], 
              "round_2" : [{"work": 60, "rest": 30}],
   }};




}