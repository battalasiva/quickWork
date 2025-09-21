import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/constants/app_sizes.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/common/commonMethods.dart';
import 'package:quickWork/data/model/work-category/GetWorkCategoriesModel.dart';
import 'package:quickWork/presentations/cubit/work-category/get-work-categories/get_work_categories_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/get-work-categories/get_work_categories_state.dart';
import 'package:quickWork/presentations/screens/users/workPostingScreen.dart';

class HomeServicesGrid extends StatefulWidget {
  const HomeServicesGrid({super.key});

  @override
  State<HomeServicesGrid> createState() => _HomeServicesGridState();
}

class _HomeServicesGridState extends State<HomeServicesGrid> {

  @override
  void initState() {
    super.initState();
    context.read<GetWorkCategoriesCubit>().fetchWorkCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.width(16),
            vertical: AppSizes.height(12),
          ),
          child: Text(
            'Available Services',
            style: TextStyle(
              fontSize: AppSizes.font(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        BlocBuilder<GetWorkCategoriesCubit, GetWorkCategoriesState>(
          builder: (context, state) {
            if (state is GetWorkCategoriesLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Loading Services...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
              );
            } else if (state is GetWorkCategoriesError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Error: ${state.message}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            } else if (state is GetWorkCategoriesSuccess) {
              final categories = state.categories;

              if (categories.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "No services available.",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: AppSizes.width(12)),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryType = category.category ?? 'HANDYMAN';

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSizes.height(4)),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Workpostingscreen(cetrgoryId: category.id ?? 0),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSizes.width(16),
                        vertical: AppSizes.height(8),
                      ),
                      leading: Container(
                        width: AppSizes.width(50),
                        height: AppSizes.height(50),
                        decoration: BoxDecoration(
                          color: ServiceConstants.getCategoryColor(categoryType),
                          borderRadius: BorderRadius.circular(
                            AppSizes.radius(12),
                          ),
                        ),
                        child: Icon(
                          ServiceConstants.getCategoryIcon(categoryType),
                          size: AppSizes.iconSize(24),
                          color: Colors.black87,
                        ),
                      ),
                      title: Text(
                        category.name ?? "NA",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: AppSizes.font(16),
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: AppSizes.iconSize(16),
                        color: AppColor.primaryColor1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radius(12),
                        ),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: AppSizes.width(1),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
