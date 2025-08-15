import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/text_keys.dart';
import 'package:quickWork/core/utils/local-storage/Shared_prefs.dart';

import 'package:quickWork/data/model/auth/signin_model.dart';
import 'package:quickWork/domain/usecase/auth/signin_usecase.dart';
import 'package:quickWork/presentations/screens/auth/profile/Complete_profile.dart';
import 'package:quickWork/core/common/elements/BottomTabBase.dart';
import 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInValidationUseCase useCase;

  SignInCubit({required this.useCase}) : super(SignInInitial());

  Future<void> signIn(
    BuildContext context,
    String mobileNumber,
    String otp,
  ) async {
    print('trigger otp 1 mobileNumber: $mobileNumber -- OTP: $otp');

    if (otp.isEmpty || otp.length < 6) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(
            otp.isEmpty ? 'Please enter otp' : 'Please enter valid otp',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      emit(SignInLoading());
      final signEntity = await useCase(mobileNumber, otp);
      print('signEntity: $signEntity');

      if (signEntity.data?.token != null &&
          signEntity.data!.token!.isNotEmpty) {
        await SharedPrefsHelper.saveString(
          AppKeys.authKey,
          signEntity.data?.token ?? '',
        );
        await SharedPrefsHelper.saveString(
          'REFRESH_TOKEN',
          signEntity.data?.refreshToken ?? '',
        );
        if (signEntity.data?.register == true) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => BottomTabNavigator()),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => CompleteProfileScreen(
                mobileNumber: signEntity.data?.primaryContact,
              ),
            ),
            (route) => false,
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid OTP'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      emit(SignInLoaded(signEntity));
    } catch (e) {
      print('Sign in error: $e');
      emit(SignInError('Failed to validate OTP'));
    }
  }
}
