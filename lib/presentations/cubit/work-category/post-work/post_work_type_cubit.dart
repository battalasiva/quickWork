import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/work-category/post_work_type_usecase.dart';
import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';
import 'post_work_type_state.dart';

class PostWorkTypeCubit extends Cubit<PostWorkTypeState> {
  final PostWorkTypeUseCase useCase;
  final NetworkService networkService;

  PostWorkTypeCubit(this.useCase, this.networkService)
    : super(PostWorkTypeInitial());

  Future<void> createWorkType(
    BuildContext context,
    Map<String, dynamic> body,
  ) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(PostWorkTypeLoading());
      await useCase(body);
      emit(PostWorkTypeSuccess());
    } catch (e) {
      emit(PostWorkTypeError("Failed to create work type: ${e.toString()}"));
    }
  }
}
