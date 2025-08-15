import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  final bool? isLeading;
  final List<Widget>? actions;

  const TopBar({
    super.key,
    required this.title,
    this.bottom,
    this.isLeading = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(22),
        bottomRight: Radius.circular(22),
      ),
      child: AppBar(
        backgroundColor: AppColor.primaryColor1,
        automaticallyImplyLeading: false,
        leading: isLeading!
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColor.white,
                  size: 24,
                ),
              )
            : null,
        title: Text(title, style: txt_17_800.copyWith(color: AppColor.white)),
        centerTitle: true,
        actions: actions ?? [],
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
