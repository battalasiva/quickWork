import 'package:quickWork/data/model/auth/trigger_otp_model.dart';
import 'package:quickWork/domain/repository/auth/trigger_otp_repository.dart';

class TriggerOtpValidationUseCase {
  final TriggerOtpRepository repository;

  TriggerOtpValidationUseCase({required this.repository});

  Future<TriggerOtpModel> call(String mobileNumber) async {
    return await repository.getOtp(mobileNumber);
  }
}
