import 'package:dio/dio.dart';
import 'package:quickWork/core/constants/api_urls.dart';
import 'package:quickWork/data/model/auth/signin_model.dart';

abstract class SignInRemoteDataSource {
  Future<SignInModel> signIn(String mobileNumber, String otp);
}

class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  final Dio client;

  SignInRemoteDataSourceImpl({required this.client});

  @override
  Future<SignInModel> signIn(String mobileNumber, String otp) async {
    final payload = {"otp": otp, "primaryContact": mobileNumber};

    try {
      print('Sending payload: $payload');

      final response = await client.request(
        '$baseUrl$signinUrl',
        options: Options(method: 'POST'),
        data: payload,
      );

      print('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        return SignInModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load OTP data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load OTP data: ${e.toString()}');
    }
  }
}
