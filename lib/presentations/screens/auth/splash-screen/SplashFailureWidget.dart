import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/image_const.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/presentations/widgets/elements/ConfirmationDialog.dart';

class SplashFailureWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  final VoidCallback onLogout;

  const SplashFailureWidget({
    Key? key,
    required this.onRefresh,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(noData, height: 250, width: 300),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onRefresh,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColor.primaryColor1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Refresh',
                    style: txt_15_500.copyWith(color: AppColor.primaryColor1),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialog(
                        title: 'Are you sure you want to logout?',
                        onConfirm: onLogout,
                        onCancel: () => Navigator.of(context).pop(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColor.primaryColor1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: txt_15_500.copyWith(color: AppColor.primaryColor1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Please Check Your Internet Connection!',
              style: txt_14_600.copyWith(color: AppColor.greyText2),
            ),
          ],
        ),
      ),
    );
  }
}
