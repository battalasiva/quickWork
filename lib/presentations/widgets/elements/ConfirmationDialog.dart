import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.white,
      title: Text(title, style: txt_16_600.copyWith(color: AppColor.black)),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('Cancel')),
        TextButton(onPressed: onConfirm, child: const Text('OK')),
      ],
    );
  }
}
