import 'package:flutter/material.dart';

// Editable display of time following the format '00:00:00'
class TimeDisplayField extends StatefulWidget
{
  final Duration time;
  final String label;
  final Color labelColor;
  final Color timeColor;
  final bool hideBorder;
  final Function(Duration newDuration) onTimeChanged;

  TimeDisplayField({
    super.key,
    required this.time,
    this.label = "",
    this.labelColor = Colors.white,
    this.timeColor = Colors.white,
    this.hideBorder = false,
    required this.onTimeChanged,
  });

  /// Return string of [Duration] in format 00:00:00
  static String timeDisplay(Duration time)
  {
    String h = time.inHours.remainder(60).toString().padLeft(2, '0');
    String m = time.inMinutes.remainder(60).toString().padLeft(2, '0');
    String s = time.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

 @override
  State<TimeDisplayField> createState() => _TimeDisplayFieldState();
}

class _TimeDisplayFieldState extends State<TimeDisplayField> {
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  late TextEditingController _secondsController;

  
  @override
  void initState()
  {
    super.initState();
    // [NOTE]: using remainder means if entering more than 59 hours will not display correctly until
    // the duration is <= 59 hours
    // This can be adjusted if needed but most people will not realistically require
    // such duration
    _hoursController = TextEditingController(
      text: _padTime(widget.time.inHours)
    );
    _minutesController = TextEditingController(
      text:  _padTime(widget.time.inMinutes)
    );
    _secondsController = TextEditingController(
      text:  _padTime(widget.time.inSeconds)
    );

    _hoursController.addListener(_updateDuration);
    
    _secondsController.addListener(_updateDuration);
    
    _minutesController.addListener(_updateDuration);
  }

  String _padTime(int time)
  {
    return time.remainder(60).toString().padLeft(2, '0');
  }

  void _updateDuration() {
     // Try to display the time of the phaseTimer otherwise default to 0
    int hours = int.tryParse(_hoursController.text) ?? 0;
    int minutes = int.tryParse(_minutesController.text) ?? 0;
    int seconds = int.tryParse(_secondsController.text) ?? 0;

    Duration newDuration = Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
    widget.onTimeChanged(newDuration);
  }

  @override
  void dispose()
  {
     _hoursController.removeListener(_updateDuration);
    _secondsController.removeListener(_updateDuration);
    _minutesController.removeListener(_updateDuration);
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();

    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {

    var cursorColor = Theme.of(context).colorScheme.inversePrimary;
    int timeDisplayLength = 2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(widget.label != "")
          Text(
            widget.label,
            style: TextStyle(fontSize: 30, color: widget.labelColor),
          ),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _hoursController,
            keyboardType: TextInputType.number,
            cursorColor: cursorColor,
            maxLength: timeDisplayLength,
            buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: widget.timeColor),
          ),
        ),
        Text(
          ":",
          style: TextStyle(fontSize: 30, color: widget.timeColor),
        ),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _minutesController,
            keyboardType: TextInputType.number,
            maxLength: timeDisplayLength,
            cursorColor: cursorColor,
            buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: widget.timeColor),
          ),
        ),
        Text(
          ":",
          style: TextStyle(fontSize: 30, color: widget.timeColor),
        ),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _secondsController,
            keyboardType: TextInputType.number,
            maxLength: timeDisplayLength,
            cursorColor: cursorColor,
            buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: widget.timeColor),
          ),
        ),
      ],
    );
  }
}
