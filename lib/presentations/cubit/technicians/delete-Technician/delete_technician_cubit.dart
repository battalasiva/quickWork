import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/technicians/delete_technician_usecase.dart';

import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';
import 'delete_technician_state.dart';

class DeleteTechnicianCubit extends Cubit<DeleteTechnicianState> {
  final DeleteTechnicianUseCase useCase;
  final NetworkService networkService;

  DeleteTechnicianCubit(this.useCase, this.networkService)
    : super(DeleteTechnicianInitial());

  Future<void> deleteTechnician(BuildContext context, int id) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(DeleteTechnicianLoading());
      await useCase(id);
      emit(DeleteTechnicianSuccess());
    } catch (e) {
      emit(
        DeleteTechnicianError("Failed to delete technician: ${e.toString()}"),
      );
    }
  }
}

// context.read<DeleteTechnicianCubit>().deleteTechnician(
//   context,
//   5, // example: delete technician with id = 5
// );
