import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/sizes.dart';

class TopBarSection extends StatefulWidget {
  final String? availableBalance, totalAmount;
  const TopBarSection({super.key, this.availableBalance, this.totalAmount});

  @override
  State<TopBarSection> createState() => _TopBarSectionState();
}

class _TopBarSectionState extends State<TopBarSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Container(
          width: getWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Work",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // LocationDisplay()
                    // Text('Click Here \nFor App Development',
                    //     style: TextStyle(
                    //       color: AppColor.white,
                    //       fontSize: 13,
                    //       fontWeight: FontWeight.bold,
                    //     )),
                  ],
                ),
              ),
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.wallet,
                      //     color: AppColor.white,
                      //     size: 30,
                      //   ),
                      //   onPressed: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(
                      //     //       builder: (_) => WalletScreen(
                      //     //             availableBalance: widget.availableBalance,
                      //     //             totalAmount: widget.totalAmount,
                      //     //           )),
                      //     // );
                      //   },
                      // ),
                      // Positioned(
                      //   top: -6,
                      //   right: -6,
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 6,
                      //       vertical: 2,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: AppColor.black,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Text(
                      //       '₹ ${widget.availableBalance ?? '0'}',
                      //       style: TextStyle(
                      //         color: AppColor.white,
                      //         fontSize: 10,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: Icon(Icons.list_alt_outlined, color: AppColor.white),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => MyOrdersScreen()),
                      // );
                    },
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: Icon(Icons.notifications, color: AppColor.white),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (_) => const NotificationScreen()),
                      // );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
