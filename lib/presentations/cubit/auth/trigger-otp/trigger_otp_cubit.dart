import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quickWork/domain/usecase/auth/trigger_otp_usecase.dart';
import 'package:quickWork/presentations/screens/auth/login/otpScreen.dart';
import 'package:quickWork/core/common/elements/custom_snackbar.dart';

import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';
import 'trigger_otp_state.dart';

class TriggerOtpCubit extends Cubit<TriggerOtpState> {
  final TriggerOtpValidationUseCase useCase;
  final NetworkService networkService;

  TriggerOtpCubit({required this.useCase, required this.networkService})
    : super(TriggerOtpInitial());

  Future<void> fetchOtp(BuildContext context, String mobileNumber) async {
    bool isConnected = await networkService.hasInternetConnection();
    if (!isConnected) {
      print("No Internet Connection");
      CustomSnackbars.showErrorSnack(
        context: context,
        title: 'Alert',
        message: 'Please check Internet Connection',
      );

      return;
    }

    if (mobileNumber.isEmpty) {
      CustomSnackbars.showErrorSnack(
        context: context,
        title: 'Attention',
        message: 'Please enter a mobile number',
      );
      return;
    } else if (mobileNumber.length < 10) {
      CustomSnackbars.showErrorSnack(
        context: context,
        message: 'Please enter a valid mobile number',
        title: 'Attention',
      );
      return;
    }

    try {
      emit(TriggerOtpLoading());
      final otpEntity = await useCase(mobileNumber);
      emit(TriggerOtpLoaded(otpEntity));

      final otpValue = otpEntity.data?.otp?.isNotEmpty == true
          ? otpEntity.data?.otp!
          : 'true';
      print('OTPPPPP $otpValue');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OtpScreen(mobileNumber: mobileNumber, otp: otpValue.toString()),
        ),
      );

      print('OTP response received and stored in state');
    } catch (e) {
      print('error in trigger otp: $e');
      emit(TriggerOtpError('Failed to load OTP data'));
    }
  }

  Future<void> resendOtp(BuildContext context, String mobileNumber) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      final otpEntity = await useCase(mobileNumber);
      emit(ResendOtpLoaded(otpEntity));
      // if (otpEntity.creationTime?.isNotEmpty == true) {
      //   final otpValue =
      //       otpEntity.otp?.isNotEmpty == true ? otpEntity.otp! : 'true';
      //   print('otpValue : $otpValue');
      // } else {
      //   CustomSnackbars.showErrorSnack(
      //     context: context,
      //     title: 'Alert',
      //     message: 'Something went wrong, please try again later',
      //   );
      // }
    } catch (e) {
      print(e);
    }
  }
}
