abstract class DeleteWorkCategoryState {}

class DeleteWorkCategoryInitial extends DeleteWorkCategoryState {}

class DeleteWorkCategoryLoading extends DeleteWorkCategoryState {}

class DeleteWorkCategorySuccess extends DeleteWorkCategoryState {}

class DeleteWorkCategoryError extends DeleteWorkCategoryState {
  final String message;
  DeleteWorkCategoryError(this.message);
}
