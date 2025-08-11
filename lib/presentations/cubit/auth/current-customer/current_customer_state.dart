import 'package:quickWork/data/model/auth/current_Customer_modal.dart';

abstract class CurrentCustomerState {}

class CurrentCustomerInitial extends CurrentCustomerState {}

class CurrentCustomerLoading extends CurrentCustomerState {}

class CurrentCustomerSuccess extends CurrentCustomerState {
  final CurrentCustomerModal customer;

  CurrentCustomerSuccess(this.customer);
}

class CurrentCustomerError extends CurrentCustomerState {
  final String message;

  CurrentCustomerError(this.message);
}
