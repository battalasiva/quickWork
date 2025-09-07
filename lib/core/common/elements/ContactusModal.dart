import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quickWork/core/common/commonMethods.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsModal extends StatelessWidget {
  const ContactUsModal({super.key});
  void _launchPhone() async {
    await launchUrl(
      Uri(scheme: 'tel', path: '9010737075'),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.phone, color: AppColor.primaryColor1),
                    title: Text(
                      'Call Us',
                      style: txt_15_500.copyWith(color: AppColor.black1),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColor.black1,
                    ),
                    onTap: _launchPhone,
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.email, color: AppColor.primaryColor1),
                    title: Text(
                      'Email Us',
                      style: txt_15_500.copyWith(color: AppColor.black1),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColor.black1,
                    ),
                    onTap: launchEmail,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
