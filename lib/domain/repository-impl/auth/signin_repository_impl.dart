import 'package:quickWork/data/datasource/auth/signin_remote_data_source.dart';
import 'package:quickWork/data/model/auth/signin_model.dart';
import 'package:quickWork/domain/repository/auth/signin_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInRemoteDataSource remoteDataSource;

  SignInRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SignInModel> logIn(String mobileNumber, String otp) async {
    final model = await remoteDataSource.signIn(mobileNumber, otp);
    return SignInModel(
      message: model.message,
      status: model.status,
      data: model.data,
    );
  }
}
