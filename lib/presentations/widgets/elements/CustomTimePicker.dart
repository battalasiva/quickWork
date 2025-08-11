import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';

class Customtimepicker extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<String> onTimeSelected;
  final bool is24HourFormat;
  final bool showIconTitle;
  final bool disablePastTime; // ✅ New flag

  const Customtimepicker({
    Key? key,
    this.initialTime,
    required this.onTimeSelected,
    this.is24HourFormat = false,
    this.showIconTitle = false,
    this.disablePastTime = false, // ✅ Default: false
  }) : super(key: key);

  @override
  _CustomtimepickerState createState() => _CustomtimepickerState();
}

class _CustomtimepickerState extends State<Customtimepicker> {
  TimeOfDay? _selectedTime;

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: widget.initialTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // ✅ Validation if disablePastTime is true
      if (widget.disablePastTime && !_isTimeValid(pickedTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot select past time')),
        );
        return;
      }

      setState(() {
        _selectedTime = pickedTime;
      });

      String formattedTime;
      if (widget.is24HourFormat) {
        formattedTime =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
      } else {
        formattedTime = _formatTime12Hour(pickedTime);
      }

      widget.onTimeSelected(formattedTime);
    }
  }

  // ✅ Helper to validate if time is not in the past
  bool _isTimeValid(TimeOfDay picked) {
    final now = TimeOfDay.now();
    final pickedMinutes = picked.hour * 60 + picked.minute;
    final nowMinutes = now.hour * 60 + now.minute;
    return pickedMinutes >= nowMinutes;
  }

  String _formatTime12Hour(TimeOfDay time) {
    final int hour = time.hourOfPeriod;
    final String period = time.period == DayPeriod.am ? "AM" : "PM";
    return "${hour == 0 ? 12 : hour}:${time.minute.toString().padLeft(2, '0')} $period";
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _selectedTime != null
        ? (widget.is24HourFormat
              ? "${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}"
              : _formatTime12Hour(_selectedTime!))
        : "Pick Time";

    return GestureDetector(
      onTap: () => _selectTime(context),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColor.primaryColor2,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: widget.showIconTitle
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      displayText,
                      style: txt_13_500.copyWith(color: AppColor.black1),
                    ),
                  ],
                )
              : Text(
                  displayText,
                  style: txt_13_500.copyWith(color: AppColor.black1),
                ),
        ),
      ),
    );
  }
}
