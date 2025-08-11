import 'package:quickWork/data/datasource/auth/trigger_otp_remote_data_source.dart';
import 'package:quickWork/data/model/auth/trigger_otp_model.dart';
import 'package:quickWork/domain/repository/auth/trigger_otp_repository.dart';

class TriggerOtpRepositoryImpl implements TriggerOtpRepository {
  final TriggerOtpRemoteDataSource remoteDataSource;

  TriggerOtpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TriggerOtpModel> getOtp(String mobileNumber) async {
    final model = await remoteDataSource.fetchOtp(mobileNumber);
    return TriggerOtpModel(data: model.data);
  }
}
