import 'package:quickWork/data/model/auth/current_Customer_modal.dart';
import 'package:quickWork/domain/repository/auth/current_customer_repository.dart';

class CurrentCustomerUseCase {
  final CurrentCustomerRepository repository;

  CurrentCustomerUseCase(this.repository);

  Future<CurrentCustomerModal> call() {
    return repository.getCurrentCustomer();
  }
}
