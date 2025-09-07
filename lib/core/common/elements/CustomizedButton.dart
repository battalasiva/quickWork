import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';

class CustomizedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle style;
  final bool isReadOnly;
  final bool isLoading;

  const CustomizedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.style,
    this.isReadOnly = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isReadOnly ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isReadOnly ? Colors.grey : AppColor.primaryColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? CupertinoActivityIndicator(color: AppColor.white)
            : Text(label, style: style),
      ),
    );
  }
}
