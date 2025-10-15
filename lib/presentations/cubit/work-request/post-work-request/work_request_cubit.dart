import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/work-request/create_work_request_usecase.dart';

import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';
import 'work_request_state.dart';

class WorkRequestCubit extends Cubit<WorkRequestState> {
  final CreateWorkRequestUseCase useCase;
  final NetworkService networkService;

  WorkRequestCubit(this.useCase, this.networkService)
    : super(WorkRequestInitial());

  Future<void> createWorkRequest(
    BuildContext context,
    Map<String, dynamic> body,
  ) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(WorkRequestLoading());
      await useCase(body);
      emit(WorkRequestSuccess());
    } catch (e) {
      emit(WorkRequestError("Failed to create Work Request: ${e.toString()}"));
    }
  }
}

// context.read<WorkRequestCubit>().createWorkRequest(
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
