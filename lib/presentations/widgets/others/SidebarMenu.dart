import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/constants/app_sizes.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/utils/local-storage/Shared_prefs.dart';
import 'package:quickWork/core/common/elements/ConfirmationDialog.dart';
import 'package:quickWork/core/common/elements/ContactusModal.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_state.dart';
import 'package:quickWork/presentations/screens/admin/AdminServicesList.dart';
import 'package:quickWork/presentations/screens/admin/WorkPostList.dart';
import 'package:quickWork/presentations/screens/auth/login/login.dart';
import 'package:quickWork/presentations/screens/common/TermsandConditions.dart';
import 'package:quickWork/presentations/screens/technicians/RaiseTechnicianRequest.dart';
import 'package:quickWork/presentations/screens/technicians/Technicianslist.dart'
    hide Text;

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  void showContactUsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactUsModal(),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.height(6)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.width(5),
          vertical: AppSizes.height(8),
        ),
        leading: Container(
          width: AppSizes.width(40),
          height: AppSizes.height(40),
          decoration: BoxDecoration(
            color: AppColor.primaryColor1.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColor.primaryColor1,
            size: AppSizes.iconSize(22),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.font(14),
          ),
        ),
        trailing: Icon(Icons.chevron_right, size: AppSizes.iconSize(20)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius(10)),
          side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentCustomerCubit, CurrentCustomerState>(
      listener: (context, state) {
        if (state is CurrentCustomerError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is CurrentCustomerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CurrentCustomerSuccess) {
          final user = state.customer.data;

          // Extract role booleans
          final roles = user?.roles?.map((e) => e.name).toList() ?? [];
          final bool isTechnician = roles.contains("ROLE_TECHNICIAN");
          final bool isAdmin = roles.contains("ROLE_USER_ADMIN");
          final bool isUser = roles.contains("ROLE_USER");

          return Drawer(
            child: Container(
              color: AppColor.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: AppSizes.height(140),
                    width: double.infinity,
                    color: AppColor.primaryColor1,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.width(20)),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: AppSizes.radius(25),
                              backgroundColor: AppColor.white,
                              child: Icon(
                                Icons.person,
                                color: AppColor.primaryColor1,
                                size: AppSizes.iconSize(30),
                              ),
                            ),
                            SizedBox(width: AppSizes.width(15)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Menu',
                                  style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: AppSizes.font(20),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (user?.primaryContact != null)
                                  Text(
                                    user!.primaryContact!,
                                    style: TextStyle(
                                      color: AppColor.white.withOpacity(0.9),
                                      fontSize: AppSizes.font(14),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(AppSizes.width(20)),
                      children: [
                        if (isAdmin) ...[
                          _buildListTile(
                            Icons.manage_accounts_outlined,
                            "Manage Services",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Adminserviceslist(),
                                ),
                              );
                            },
                          ),
                          _buildListTile(
                            Icons.supervised_user_circle_outlined,
                            "Technicians List",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Technicianslist(),
                                ),
                              );
                            },
                          ),
                        ],
                        _buildListTile(
                          Icons.work_history_outlined,
                          "Posted Works",
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkpostList(),
                              ),
                            );
                          },
                        ),
                        if (!isAdmin) ...[
                          _buildListTile(
                            Icons.sensor_occupied_outlined,
                            "Request To Technician",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Raisetechnicianrequest(),
                                ),
                              );
                            },
                          ),

                          _buildListTile(Icons.support_agent, "Support", () {
                            showContactUsModal(context);
                          }),
                        ],
                        _buildListTile(
                          Icons.description_outlined,
                          "Terms & Conditions",
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Termsandconditions(),
                              ),
                            );
                          },
                        ),
                        _buildListTile(Icons.logout, "Logout", () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                              title: 'Are you sure you want to logout?',
                              onConfirm: () async {
                                Navigator.pop(context); // Close dialog
                                Navigator.pop(context); // Close drawer
                                await SharedPrefsHelper.clearAllData();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              onCancel: () => Navigator.of(context).pop(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppSizes.width(20)),
                    child: Text(
                      "App Version: v1.0.1",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: AppSizes.font(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
