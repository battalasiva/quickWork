import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/common/elements/AppLoaderWidget.dart';
import 'package:quickWork/core/common/elements/ConfirmationDialog.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';
import 'package:quickWork/data/model/work-category/GetWorkCategoriesModel.dart';
import 'package:quickWork/presentations/cubit/work-category/delete-work-category/delete_work_category_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/delete-work-category/delete_work_category_state.dart';
import 'package:quickWork/presentations/cubit/work-category/get-work-categories/get_work_categories_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/get-work-categories/get_work_categories_state.dart';
import 'package:quickWork/presentations/screens/admin/bottomsheets/AdminServiceBottomSheet.dart';

class Adminserviceslist extends StatefulWidget {
  const Adminserviceslist({super.key});

  @override
  State<Adminserviceslist> createState() => _AdminserviceslistState();
}

class _AdminserviceslistState extends State<Adminserviceslist> {
  final TextEditingController _serviceController = TextEditingController();
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    context.read<GetWorkCategoriesCubit>().fetchWorkCategories(context);
  }

  void _openBottomSheet({required bool isEdit, String? initialValue}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AdminServiceBottomSheet(
          isEdit: isEdit,
          controller: _serviceController,
          initialValue: initialValue,
          onSuccess: () {
            context.read<GetWorkCategoriesCubit>().fetchWorkCategories(context);
          },
        );
      },
    );
  }

  void _deleteCategory(int id) {
    showDialog(
      context: context,
      builder: (context) =>
          BlocConsumer<DeleteWorkCategoryCubit, DeleteWorkCategoryState>(
            listener: (context, state) {
              if (state is DeleteWorkCategorySuccess) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Service deleted successfully")),
                );
                context.read<GetWorkCategoriesCubit>().fetchWorkCategories(
                  context,
                );
              } else if (state is DeleteWorkCategoryError) {
                Navigator.of(context).pop(); // close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error while Deleting....')),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is DeleteWorkCategoryLoading;

              return ConfirmationDialog(
                title: isLoading
                    ? "Deleting..."
                    : "Are you sure you want to Delete?",

                onConfirm: () {
                  if (!isLoading) {
                    context.read<DeleteWorkCategoryCubit>().deleteCategory(
                      context,
                      id,
                    );
                  }
                },
                onCancel: () => Navigator.of(context).pop(),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Manage Services'),
      body: BlocBuilder<GetWorkCategoriesCubit, GetWorkCategoriesState>(
        builder: (context, state) {
          if (state is GetWorkCategoriesLoading) {
            return const Center(child: AppLoader());
          } else if (state is GetWorkCategoriesError) {
            return Center(
              child: Text(
                state.message,
                style: txt_15_500.copyWith(color: AppColor.red),
              ),
            );
          } else if (state is GetWorkCategoriesSuccess) {
            final List<GetWorkCategoriesModel> categories = state.categories;

            if (categories.isEmpty) {
              return Center(
                child: Text(
                  "No services available",
                  style: txt_15_500.copyWith(color: AppColor.black),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final category = categories[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor3,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      category.name ?? '',
                      style: txt_15_500.copyWith(color: AppColor.black),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit Button (optional, you can enable later)
                        // IconButton(
                        //   icon: Icon(Icons.edit, color: AppColor.black),
                        //   onPressed: () {
                        //     editingIndex = index;
                        //     _serviceController.text = category.name ?? '';
                        //     _openBottomSheet(
                        //       isEdit: true,
                        //       initialValue: category.name,
                        //     );
                        //   },
                        // ),

                        // Delete Button
                        IconButton(
                          icon: Icon(Icons.delete, color: AppColor.red),
                          onPressed: () => _deleteCategory(category.id ?? 0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink(); // For initial state
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          editingIndex = null;
          _serviceController.clear();
          _openBottomSheet(isEdit: false);
        },
        child: Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.primaryColor1,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Text(
            "Add Service",
            style: txt_15_500.copyWith(color: AppColor.white),
          ),
        ),
      ),
    );
  }
}
