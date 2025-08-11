import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/presentations/widgets/elements/CustomDatePicker.dart';
import 'package:quickWork/presentations/widgets/elements/CustomTimePicker.dart';
import 'package:quickWork/presentations/widgets/elements/CustomizedButton.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? initialDate;
  final String? initialTime;
  final Function(String selectedDate, String selectedTime) onApply;

  const FilterBottomSheet({
    Key? key,
    this.initialDate,
    this.initialTime,
    required this.onApply,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedDate = '';
  String selectedTime = '';

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? '';
    selectedTime = widget.initialTime ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Apply Filters",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              /// Combined Row for Date & Time Pickers
              Row(
                children: [
                  /// Date Picker
                  Expanded(
                    child: Container(
                      height: 55,
                      margin: const EdgeInsets.only(right: 8),
                      child: CustomDatePicker(
                        showIcon: true,
                        format: 'YYYY-MM-DD',
                        initialDate: selectedDate,
                        showIconTitle: true,
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    ),
                  ),

                  /// Time Picker
                  Expanded(
                    child: Container(
                      height: 55,
                      margin: const EdgeInsets.only(left: 8),
                      child: Customtimepicker(
                        initialTime: TimeOfDay.now(),
                        showIconTitle: true,
                        onTimeSelected: (time) {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                        is24HourFormat: true,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Apply Button
              CustomizedButton(
                label: 'Apply Filters',
                isLoading: false,
                style: txt_15_500.copyWith(color: AppColor.white),
                onPressed: () {
                  Navigator.pop(context);
                  widget.onApply(selectedDate, selectedTime);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
