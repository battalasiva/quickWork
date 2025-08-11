import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:quickWork/domain/usecase/auth/current_customer_usecase.dart';

import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';

import 'current_customer_state.dart';

class CurrentCustomerCubit extends Cubit<CurrentCustomerState> {
  final CurrentCustomerUseCase useCase;
  final NetworkService networkService;

  CurrentCustomerCubit(this.useCase, this.networkService)
    : super(CurrentCustomerInitial());

  Future<void> fetchCurrentCustomer(BuildContext context) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(CurrentCustomerLoading());
      final result = await useCase();
      emit(CurrentCustomerSuccess(result));
    } catch (e) {
      emit(CurrentCustomerError("Failed to load user details"));
    }
  }
}
