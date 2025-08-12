import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/common/globalData.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/utils/local-storage/Shared_prefs.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_state.dart';
import 'package:quickWork/presentations/screens/auth/login/login.dart';
import 'package:quickWork/presentations/screens/auth/splash-screen/SplashFailureWidget.dart';
import 'package:quickWork/presentations/widgets/elements/AppLoaderWidget.dart';
import 'package:quickWork/presentations/widgets/elements/ImageSlider.dart';
import 'package:quickWork/presentations/widgets/others/HomeServicesGrid.dart';
import 'package:quickWork/presentations/widgets/others/TopBarSection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '___';
  String mobileNumber = '---';
  String role = '---', availableBalance = '0', totalAmount = '0';
  bool register = true;
  bool? isAgent, isAdmin, isDeliveryBoy;
  // NotificationServices notificationServices = NotificationServices();

  int? userId;
  final globalData = GlobalData();
  @override
  void initState() {
    super.initState();
    fetchCurrentCustomer();
  }

  Future<void> fetchCurrentCustomer() async {
    await context.read<CurrentCustomerCubit>().fetchCurrentCustomer(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentCustomerCubit, CurrentCustomerState>(
      listener: (context, state) {
        print("CurrentCustomerState: $state");
        if (state is CurrentCustomerError) {
          print("Error fetching current customer: ${state.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColor.red,
            ),
          );
        } else if (state is CurrentCustomerSuccess) {
          final data = state.customer.data;
          setState(() {
            userName = data?.fullName ?? '___';
            mobileNumber = data?.primaryContact ?? '---';
            role = (data?.roles != null && data!.roles!.isNotEmpty)
                ? data.roles![0].name ?? '---'
                : '---';
            register = data?.register ?? false;
            availableBalance =
                data?.wallet?.availableBalance?.toString() ?? '0';
            totalAmount = data?.wallet?.totalAmount?.toString() ?? '0';
            globalData.userId = data?.id ?? 0;
            globalData.walletAmount =
                data?.wallet?.availableBalance?.toDouble() ?? 0.0;
            globalData.primaryContact = data?.primaryContact;
            if (data?.addresses?.isNotEmpty == true) {
              final defaultAddress = data!.addresses!.firstWhere(
                (address) => address.isDefaultAddress == true,
              );
              globalData.addressId = defaultAddress.id;
              globalData.villageId = defaultAddress.villageId;
              globalData.postalCode = defaultAddress.postalCode;
            }
            isAgent = data!.roles!.any((role) => role.name == 'ROLE_AGENT');
            isAdmin = data.roles!.any((role) => role.name == 'ROLE_USER_ADMIN');
            isDeliveryBoy = data.roles!.any(
              (role) => role.name == 'ROLE_DELIVERY_BOY',
            );
          });
          print("User Name: $userName");
          // if (!register) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) =>
          //           CompleteProfileScreen(mobileNumber: mobileNumber),
          //     ),
          //   ).then((result) {
          //     if (result ?? false) {
          //       fetchCurrentCustomer();
          //     }
          //   });
          // }
        }
      },
      builder: (context, state) {
        // if (state is CurrentCustomerLoading) {
        //   return Scaffold(
        //     backgroundColor: AppColor.white,
        //     body: const Center(child: AppLoader()),
        //   );
        // }
        // if (state is CurrentCustomerError) {
        //   return SplashFailureWidget(
        //     onRefresh: fetchCurrentCustomer,
        //     onLogout: () async {
        //       SharedPrefsHelper.clearAllData();
        //       Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(builder: (context) => LoginScreen()),
        //         (route) => false,
        //       );
        //     },
        //   );
        // }
        return Scaffold(
          backgroundColor: AppColor.white,
          body: RefreshIndicator(
            onRefresh: fetchCurrentCustomer,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: Container(
                      color: AppColor.primaryColor1,
                      child: Column(
                        children: [
                          TopBarSection(
                            availableBalance: availableBalance,
                            totalAmount: totalAmount,
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 200, child: ImageSlider()),
                  const SizedBox(height: 5),
                  HomeServicesGrid(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
