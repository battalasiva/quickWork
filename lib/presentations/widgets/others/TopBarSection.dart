import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/app_sizes.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/sizes.dart';
import 'package:quickWork/core/common/commonMethods.dart';
import 'package:quickWork/presentations/screens/common/NoticationsList.dart';
import 'package:quickWork/presentations/screens/users/WorksHistory.dart';

class TopBarSection extends StatefulWidget {
  final String? availableBalance, totalAmount;
  const TopBarSection({super.key, this.availableBalance, this.totalAmount});

  @override
  State<TopBarSection> createState() => _TopBarSectionState();
}

class _TopBarSectionState extends State<TopBarSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.width(16),
        vertical: AppSizes.height(20),
      ),
      margin: EdgeInsets.only(
        top: AppSizes.height(40),
        bottom: AppSizes.height(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getGreetingMessage(),
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: AppSizes.font(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              AppSizes.hSpace(5),
              IconButton(
                icon: Icon(
                  Icons.list_alt_outlined,
                  color: AppColor.white,
                  size: AppSizes.iconSize(24),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WorksHistory()),
                  );
                },
              ),
              AppSizes.hSpace(5),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: AppColor.white,
                  size: AppSizes.iconSize(24),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              AppSizes.hSpace(5),
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: AppColor.white,
                    size: AppSizes.iconSize(28),
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
