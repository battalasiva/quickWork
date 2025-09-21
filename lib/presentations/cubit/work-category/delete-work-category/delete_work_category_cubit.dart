import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/work-category/delete_work_category_usecase.dart';
import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';
import 'delete_work_category_state.dart';

class DeleteWorkCategoryCubit extends Cubit<DeleteWorkCategoryState> {
  final DeleteWorkCategoryUseCase useCase;
  final NetworkService networkService;

  DeleteWorkCategoryCubit(this.useCase, this.networkService)
    : super(DeleteWorkCategoryInitial());

  Future<void> deleteCategory(BuildContext context, int id) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(DeleteWorkCategoryLoading());
      await useCase(id);
      emit(DeleteWorkCategorySuccess());
    } catch (e) {
      emit(
        DeleteWorkCategoryError("Failed to delete category: ${e.toString()}"),
      );
    }
  }
}
