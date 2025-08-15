import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/common/commonMethods.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/sizes.dart';
import 'package:quickWork/core/utils/local-storage/Shared_prefs.dart';
import 'package:quickWork/data/model/auth/current_Customer_modal.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_state.dart';
import 'package:quickWork/presentations/screens/admin/AdminServicesList.dart';
import 'package:quickWork/presentations/screens/admin/WorkPostList.dart';
import 'package:quickWork/presentations/screens/auth/login/login.dart';
import 'package:quickWork/presentations/screens/auth/profile/Complete_profile.dart';
import 'package:quickWork/presentations/screens/common/TermsandConditions.dart';
import 'package:quickWork/core/common/elements/ConfirmationDialog.dart';
import 'package:quickWork/core/common/elements/ContactusModal.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  String? mobileNumber, userName, role;
  bool? isAgent;
  bool? isAdmin;
  bool? isDeliveryBoy;
  bool? isSystemUser;
  int? userId;
  Future<void> fetchCurrentCustomer() async {
    await context.read<CurrentCustomerCubit>().fetchCurrentCustomer(context);
  }

  String getReadableRole(List<Roles>? roles) {
    if (roles == null || roles.isEmpty) return '---';

    if (roles.length == 1 && roles.first.name == 'ROLE_USER') {
      return 'User';
    }

    final preferredRole = roles.firstWhere(
      (role) => role.name != 'ROLE_USER',
      orElse: () => roles.first,
    );

    switch (preferredRole.name) {
      case 'ROLE_USER_ADMIN':
        return 'Admin';
      case 'ROLE_AGENT':
        return 'Agent';
      case 'ROLE_DELIVERY_BOY':
        return 'Delivery Boy';
      case 'ROLE_SYSTEM_USER':
        return 'System User';
      case 'ROLE_USER':
        return 'User';
      default:
        return '---';
    }
  }

  void showContactUsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactUsModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('$isAdmin $isAgent $isDeliveryBoy');
    return Scaffold(
      appBar: TopBar(title: 'Profile', isLeading: false),
      backgroundColor: AppColor.white,
      body: RefreshIndicator(
        onRefresh: fetchCurrentCustomer,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              BlocBuilder<CurrentCustomerCubit, CurrentCustomerState>(
                builder: (context, state) {
                  userName = 'Loading...';
                  mobileNumber = 'Loading...';

                  if (state is CurrentCustomerSuccess) {
                    final data = state.customer.data;
                    userName = data?.fullName.toString() ?? '___';
                    mobileNumber = data?.primaryContact?.toString() ?? '---';
                    userId = data?.id;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        isAgent = data!.roles!.any(
                          (role) => role.name == 'ROLE_AGENT',
                        );
                        isAdmin = data.roles!.any(
                          (role) => role.name == 'ROLE_USER_ADMIN',
                        );
                        isDeliveryBoy = data.roles!.any(
                          (role) => role.name == 'ROLE_DELIVERY_BOY',
                        );
                        isSystemUser = data.roles!.any(
                          (role) => role.name == 'ROLE_SYSTEM_USER',
                        );
                        role = getReadableRole(data.roles);
                      });
                    });
                    // print('$isAdmin $isAgent $isDeliveryBoy');
                    role = getReadableRole(data?.roles);
                  } else if (state is CurrentCustomerError) {
                    userName = '___';
                    mobileNumber = '---';
                    role = '---';
                  }

                  return Container(
                    width: getWidth(context),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor2,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.primaryColor1.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName ?? '___',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                mobileNumber ?? '---',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                role ?? '---',
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CompleteProfileScreen(
                                  mobileNumber: mobileNumber,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.black87),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
              // Options List
              Expanded(
                child: ListView(
                  children: [
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
                    _buildListTile(
                      Icons.support_agent,
                      "Support",
                      () => showContactUsModal(context),
                    ),
                    _buildListTile(Icons.share, "Share", () {
                      shareFunction(
                        'Hello, check out this amazing app!\n https://play.google.com/store/apps/details?id=com.meatspot&hl=en',
                      );
                    }),
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

              const Text(
                "App Version: v1.0.3",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColor.primaryColor1.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColor.primaryColor1),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            // color: title == "Logout" ? AppColor.primaryColor1 : null,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          // color: title == "Logout" ? AppColor.primaryColor1 : AppColor.primaryColor1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        onTap: onTap,
      ),
    );
  }
}
