import 'package:quickWork/data/model/auth/signin_model.dart';
import 'package:quickWork/domain/repository/auth/signin_repository.dart';

class SignInValidationUseCase {
  final SignInRepository repository;

  SignInValidationUseCase({required this.repository});

  Future<SignInModel> call(String mobileNumber, String otp) async {
    return await repository.logIn(mobileNumber, otp);
  }
}
