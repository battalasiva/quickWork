// order_success_popup.dart
import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';

class OrderSuccessPopup extends StatelessWidget {
  const OrderSuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              'Order Placed Successfully!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close popup
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (_) => MyOrdersScreen()),
                // );
              },
              child: Text(
                'Click here to view order',
                style: TextStyle(
                  color: AppColor.primaryColor1,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
