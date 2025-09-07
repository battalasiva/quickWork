import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/presentations/cubit/auth/signin/sigin_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/signin/signin_state.dart';
import 'package:quickWork/core/common/elements/CustomizedButton.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String otp;
  const OtpScreen({super.key, required this.mobileNumber, required this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  int _secondsRemaining = 60;
  bool _canResend = false;
  late Timer _timer;
  String otp = "";

  @override
  void initState() {
    super.initState();
    otp = widget.otp;
    _startTimer();

    // 2. Request focus when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose(); // 3. Dispose focus node
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
          _timer.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _resendOtp() {
    otp = "654321"; // Simulated new OTP
    _startTimer();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("OTP resent successfully")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(title: 'Otp Screen'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Pinput(
                length: 6,
                controller: _otpController,
                focusNode: _otpFocusNode, // 4. Attach focus node here
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onCompleted: (value) {
                  context.read<SignInCubit>().signIn(
                    context,
                    widget.mobileNumber,
                    value,
                  );
                },
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'OTP: $otp',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              BlocConsumer<SignInCubit, SignInState>(
                listener: (context, state) {
                  if (state is SignInLoaded) {
                    // Navigate to next screen or show success message
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text("OTP sent successfully")),
                    // );
                  } else if (state is SignInError) {
                    // Show error message
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return CustomizedButton(
                    isLoading: (state is SignInLoading),
                    label: 'Verify OTP',
                    style: txt_15_500.copyWith(color: AppColor.white),
                    onPressed: () {
                      if (_otpController.text.length == 6) {
                        context.read<SignInCubit>().signIn(
                          context,
                          widget.mobileNumber,
                          _otpController.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid 6-digit OTP.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
