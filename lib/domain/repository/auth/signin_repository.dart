import 'package:quickWork/data/model/auth/signin_model.dart';

abstract class SignInRepository {
  Future<SignInModel> logIn(String mobileNumber, String otp);
}
