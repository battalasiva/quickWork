import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/image_const.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/presentations/cubit/auth/trigger-otp/trigger_otp_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/trigger-otp/trigger_otp_state.dart';
import 'package:quickWork/core/common/elements/CustomizedButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();

  // void _validateAndLogin() {
  //   final mobile = _mobileController.text.trim();

  //   if (mobile.isEmpty || mobile.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(mobile)) {
  //     CustomSnackbarWidget(
  //       context: context,
  //       title: 'Enter valid mobile number',
  //       backgroundColor: AppColor.red,
  //     );
  //     return;
  //   }

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => OtpScreen(mobileNumber: '', otp: '', fullName: '',)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                // App logo
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(iclauncher),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 32),

                // Mobile number input field
                TextField(
                  controller: _mobileController,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    hintText: 'Enter Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Login button
                BlocConsumer<TriggerOtpCubit, TriggerOtpState>(
                  listener: (context, state) {
                    if (state is TriggerOtpLoaded) {
                      // Navigate to next screen or show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("OTP sent successfully")),
                      );
                    } else if (state is TriggerOtpError) {
                      // Show error message
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return CustomizedButton(
                      label: 'Login',
                      isLoading: state is TriggerOtpLoading,
                      style: txt_15_500.copyWith(color: AppColor.white),
                      onPressed: () {
                        context.read<TriggerOtpCubit>().fetchOtp(
                          context,
                          _mobileController.text.trim(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
