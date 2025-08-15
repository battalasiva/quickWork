import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';

class Termsandconditions extends StatefulWidget {
  const Termsandconditions({super.key});

  @override
  State<Termsandconditions> createState() => _TermsandconditionsState();
}

class _TermsandconditionsState extends State<Termsandconditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Terms And Conditions'),
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
Privacy Policy for Quick Work
Effective Date: 29/05/2025

Welcome to Quick Work. We respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and share information when you use our mobile application.

1. Information We Collect

a. Personal Information
We collect your mobile number during login to verify your identity and create your account.

b. Location Information
We collect your device’s geolocation with your permission to provide accurate delivery services to your home or current location.

2. How We Use Your Information
- To verify your identity and create/manage your user profile.
- To provide delivery services using your real-time location.
- To assign and track delivery roles (User, Delivery Boy).
- To offer relevant offers, bonuses, and promotions.
- To improve our services and user experience.

3. Sharing of Information
We do not sell or rent your personal information. We may share limited information with:
- Delivery personnel to fulfill your orders.

4. Data Security
We take appropriate security measures to protect your personal data against unauthorized access, alteration, or disclosure.

5. User Controls
- You can update or delete your profile at any time.
- You may disable location permissions from your device settings, although some features may not function properly.

6. Children’s Privacy
Quick Work is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children.

7. Changes to This Policy
We may update this policy occasionally. We encourage you to review this page periodically.

8. Contact Us
If you have any questions or concerns about our privacy practices, please contact us at:
harishtellaputta990@gmail.com
            ''',
            style: txt_14_400.copyWith(color: AppColor.black2, height: 1.5),
          ),
        ),
      ),
    );
  }
}
