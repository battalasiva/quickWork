import 'package:quickWork/data/model/auth/current_Customer_modal.dart';

abstract class CurrentCustomerRepository {
  Future<CurrentCustomerModal> getCurrentCustomer();
}
