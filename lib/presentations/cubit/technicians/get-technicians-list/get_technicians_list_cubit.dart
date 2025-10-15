import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/technicians/get_technicians_list_usecase.dart';

import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';

import 'get_technicians_list_state.dart';

class GetTechniciansListCubit extends Cubit<GetTechniciansListState> {
  final GetTechniciansListUseCase useCase;
  final NetworkService networkService;

  GetTechniciansListCubit(this.useCase, this.networkService)
    : super(GetTechniciansListInitial());

  Future<void> fetchTechnicians(BuildContext context) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(GetTechniciansListLoading());
      final technicians = await useCase();
      emit(GetTechniciansListSuccess(technicians));
    } catch (e) {
      debugPrint('Error fetching technicians: $e');
      emit(
        GetTechniciansListError("Failed to fetch technicians: ${e.toString()}"),
      );
    }
  }
}

// context.read<GetTechniciansListCubit>().fetchTechnicians(context);
