import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/work-request/get_work_requests_list_usecase.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/network/network_helper.dart';

import 'get_work_requests_list_state.dart';
import 'package:flutter/widgets.dart';

class GetWorkRequestsListCubit extends Cubit<GetWorkRequestsListState> {
  final GetWorkRequestsListUseCase useCase;
  final NetworkService networkService;

  GetWorkRequestsListCubit(this.useCase, this.networkService)
    : super(GetWorkRequestsListInitial());

  Future<void> fetchWorkRequests(BuildContext context) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(GetWorkRequestsListLoading());
      final workRequests = await useCase();
      emit(GetWorkRequestsListLoaded(workRequests));
    } catch (e) {
      debugPrint('ERROR : $e');
      emit(
        GetWorkRequestsListError(
          "Failed to fetch work requests: ${e.toString()}",
        ),
      );
    }
  }
}

// context.read<GetWorkRequestsListCubit>().fetchWorkRequests(context);
