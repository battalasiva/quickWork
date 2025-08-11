import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';

class CustomRadioList extends StatelessWidget {
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomRadioList({
    Key? key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: selectedValue,
          onChanged: onChanged,
          activeColor: AppColor.primaryColor1,
        );
      }).toList(),
    );
  }
}
