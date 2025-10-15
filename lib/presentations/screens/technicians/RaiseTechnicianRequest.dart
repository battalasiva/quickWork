import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickWork/core/common/elements/AppLoaderWidget.dart';
import 'package:quickWork/core/common/elements/commonFields.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';
import 'package:quickWork/core/constants/app_sizes.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/common/elements/CustomizedButton.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/data/model/work-category/GetWorkCategoriesModel.dart';
import 'package:quickWork/presentations/cubit/technicians/raise-technician-request/RaiseTechnicianRequestCubit.dart';
import 'package:quickWork/presentations/cubit/technicians/raise-technician-request/RaiseTechnicianRequestState.dart';
import 'package:quickWork/presentations/cubit/work-category/get-work-categories/get_work_categories_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/get-work-categories/get_work_categories_state.dart';

class Raisetechnicianrequest extends StatefulWidget {
  const Raisetechnicianrequest({super.key});

  @override
  State<Raisetechnicianrequest> createState() => _RaisetechnicianrequestState();
}

class _RaisetechnicianrequestState extends State<Raisetechnicianrequest> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  // selected categories
  final List<GetWorkCategoriesModel> _selectedCategories = [];

  bool _isSubmitEnabled = false;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    context.read<GetWorkCategoriesCubit>().fetchWorkCategories(context);
  }

  Future<void> _fetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    await _getAddressFromCoordinates(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _postalCodeController.text = place.postalCode ?? '';
            _cityController.text = place.locality ?? '';
            _updateSubmitEnabled();
          });
        });
      }
    } catch (_) {}
  }

  void _updateSubmitEnabled() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isSubmitEnabled =
            _formKey.currentState?.validate() == true &&
            _selectedCategories.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Raise Technician Request'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name
              CommonComponents.defaultTextField(
                context,
                controller: _fullNameController,
                title: "Full Name",
                hintText: "Enter Full Name",
                // onChanged: (_) => _updateSubmitEnabled(),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Full Name is required'
                    : null,
              ),
              AppSizes.vSpace(16),

              // City
              CommonComponents.defaultTextField(
                context,
                controller: _cityController,
                title: "City",
                hintText: "Enter City",
                // onChanged: (_) => _updateSubmitEnabled(),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'City is required'
                    : null,
              ),
              AppSizes.vSpace(16),

              // Postal Code
              CommonComponents.defaultTextField(
                context,
                controller: _postalCodeController,
                title: "Postal Code",
                hintText: "Enter Postal Code",
                // onChanged: (_) => _updateSubmitEnabled(),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Postal Code is required'
                    : null,
              ),
              AppSizes.vSpace(16),

              // Categories Grid
              BlocBuilder<GetWorkCategoriesCubit, GetWorkCategoriesState>(
                builder: (context, state) {
                  if (state is GetWorkCategoriesLoading) {
                    return const Center(child: AppLoader());
                  } else if (state is GetWorkCategoriesError) {
                    return Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  } else if (state is GetWorkCategoriesSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Work Categories",
                              style: txt_13_500.copyWith(
                                color: AppColor.black1,
                              ),
                            ),
                            Text(
                              "Selected: ${_selectedCategories.length}",
                              style: txt_13_500.copyWith(color: AppColor.grey),
                            ),
                          ],
                        ),
                        AppSizes.vSpace(8),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 2.5,
                              ),
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            final isSelected = _selectedCategories.contains(
                              category,
                            );
                            return GestureDetector(
                              onTap: () {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedCategories.remove(category);
                                    } else {
                                      _selectedCategories.add(category);
                                    }
                                    _updateSubmitEnabled();
                                  });
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColor.primaryColor1
                                        : AppColor.grey,
                                    width: 1.5,
                                  ),
                                  color: isSelected
                                      ? AppColor.primaryColor1.withOpacity(0.2)
                                      : Colors.white,
                                ),
                                child: Text(
                                  category.name ?? '',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? AppColor.primaryColor1
                                        : AppColor.black1,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        AppSizes.vSpace(8),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              AppSizes.vSpace(80),
            ],
          ),
        ),
      ),

      // Bottom Button with BlocConsumer
      bottomSheet: Container(
        padding: EdgeInsets.all(AppSizes.width(16)),
        color: Colors.white,
        child:
            BlocConsumer<
              RaiseTechnicianRequestCubit,
              RaiseTechnicianRequestState
            >(
              listener: (context, state) {
                if (state is RaiseTechnicianRequestSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Request submitted successfully"),
                    ),
                  );
                } else if (state is RaiseTechnicianRequestError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final isLoading = state is RaiseTechnicianRequestLoading;

                return CustomizedButton(
                  label: 'Submit Request',
                  style: txt_15_500.copyWith(color: AppColor.white),
                  isLoading: isLoading,
                  isReadOnly: !_isSubmitEnabled || isLoading,
                  onPressed: () {
                    if (_isSubmitEnabled) {
                      final payload = {
                        "fullName": _fullNameController.text.trim(),
                        "address": {
                          "city": _cityController.text.trim(),
                          "postalCode": _postalCodeController.text.trim(),
                        },
                        "workTypeIds": _selectedCategories
                            .map((c) => c.id)
                            .toList(),
                      };

                      context.read<RaiseTechnicianRequestCubit>().raiseRequest(
                        context,
                        payload,
                      );
                    }
                  },
                );
              },
            ),
      ),
    );
  }
}
