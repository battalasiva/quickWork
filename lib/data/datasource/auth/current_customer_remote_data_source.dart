import 'package:dio/dio.dart';
import 'package:quickWork/core/constants/api_urls.dart';
import 'package:quickWork/data/model/auth/current_Customer_modal.dart';

abstract class CurrentCustomerRemoteDataSource {
  Future<CurrentCustomerModal> fetchCurrentCustomer();
}

class CurrentCustomerRemoteDataSourceImpl
    implements CurrentCustomerRemoteDataSource {
  final Dio client;

  CurrentCustomerRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentCustomerModal> fetchCurrentCustomer() async {
    try {
      final response = await client.get(currentCustomer);
      print('Response status code: ${response.data}');
      if (response.statusCode == 200) {
        return CurrentCustomerModal.fromJson(response.data);
      } else {
        throw Exception('Failed to load customer data: ${response.statusCode}');
      }
    } catch (e) {
      print('object : $e');
      throw Exception('Error fetching customer data: ${e.toString()}');
    }
  }
}
