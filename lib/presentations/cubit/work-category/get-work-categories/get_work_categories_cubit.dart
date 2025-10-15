import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/domain/usecase/work-category/get_work_categories_usecase.dart';
import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';

import 'get_work_categories_state.dart';

class GetWorkCategoriesCubit extends Cubit<GetWorkCategoriesState> {
  final GetWorkCategoriesUseCase useCase;
  final NetworkService networkService;

  GetWorkCategoriesCubit(this.useCase, this.networkService)
    : super(GetWorkCategoriesInitial());

  Future<void> fetchWorkCategories(BuildContext context) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(GetWorkCategoriesLoading());
      final categories = await useCase();
      emit(GetWorkCategoriesSuccess(categories));
    } catch (e) {
      emit(GetWorkCategoriesError("Failed to fetch categories}"));
    }
  }
}
