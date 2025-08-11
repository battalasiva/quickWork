import 'package:quickWork/data/datasource/auth/current_customer_remote_data_source.dart';
import 'package:quickWork/data/model/auth/current_Customer_modal.dart';
import 'package:quickWork/domain/repository/auth/current_customer_repository.dart';

class CurrentCustomerRepositoryImpl implements CurrentCustomerRepository {
  final CurrentCustomerRemoteDataSource remoteDataSource;

  CurrentCustomerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CurrentCustomerModal> getCurrentCustomer() {
    return remoteDataSource.fetchCurrentCustomer();
  }
}
