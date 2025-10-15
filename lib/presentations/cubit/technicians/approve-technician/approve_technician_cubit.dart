import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/technicians/approve_technician_usecase.dart';

import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';
import 'approve_technician_state.dart';

class ApproveTechnicianCubit extends Cubit<ApproveTechnicianState> {
  final ApproveTechnicianUseCase useCase;
  final NetworkService networkService;

  ApproveTechnicianCubit(this.useCase, this.networkService)
    : super(ApproveTechnicianInitial());

  Future<void> approveTechnician(BuildContext context, int id) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(ApproveTechnicianLoading());
      await useCase(id);
      emit(ApproveTechnicianSuccess());
    } catch (e) {
      emit(
        ApproveTechnicianError("Failed to approve technician: ${e.toString()}"),
      );
    }
  }
}

// context.read<ApproveTechnicianCubit>().approveTechnician(
//   context,
//   7, // example: approve technician with id = 7
// );
