import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/technicians/RaiseTechnicianRequestUseCase.dart';
import 'package:quickWork/presentations/cubit/technicians/raise-technician-request/RaiseTechnicianRequestState.dart';

import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';

class RaiseTechnicianRequestCubit extends Cubit<RaiseTechnicianRequestState> {
  final RaiseTechnicianRequestUseCase useCase;
  final NetworkService networkService;

  RaiseTechnicianRequestCubit(this.useCase, this.networkService)
    : super(RaiseTechnicianRequestInitial());

  Future<void> raiseRequest(
    BuildContext context,
    Map<String, dynamic> requestBody,
  ) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(RaiseTechnicianRequestLoading());
      await useCase(requestBody);
      emit(RaiseTechnicianRequestSuccess());
    } catch (e) {
      emit(
        RaiseTechnicianRequestError(
          "Failed to raise technician request: ${e.toString()}",
        ),
      );
    }
  }
}

// context.read<RaiseTechnicianRequestCubit>().raiseRequest(
//   context,
//   {
//     "title": "AC Installation",
//     "description": "Install new 1.5 ton split AC unit in living room",
//     "workTypeId": 2,
//     "priority": "HIGH",
//     "status": "PENDING",
//     "scheduledDate": "2025-08-15T10:30:00",
//     "address": {
//       "city": "Hyderabad",
//       "postalCode": "500081",
//     }
//   },
// );
