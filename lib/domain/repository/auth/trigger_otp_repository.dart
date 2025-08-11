import 'package:quickWork/data/model/auth/trigger_otp_model.dart';

abstract class TriggerOtpRepository {
  Future<TriggerOtpModel> getOtp(String mobileNumber);
}
