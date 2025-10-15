import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickWork/core/common/elements/CustomizedButton.dart';
import 'package:quickWork/core/common/elements/commonFields.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';
import 'package:quickWork/core/constants/app_sizes.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/presentations/cubit/work-request/post-work-request/work_request_cubit.dart';
import 'package:quickWork/presentations/cubit/work-request/post-work-request/work_request_state.dart';

class Workpostingscreen extends StatefulWidget {
  final int cetrgoryId;
  const Workpostingscreen({super.key, required this.cetrgoryId});

  @override
  State<Workpostingscreen> createState() => _WorkpostingscreenState();
}

class _WorkpostingscreenState extends State<Workpostingscreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
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
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    Placemark place = placemarks[0];
    setState(() {
      _postalCodeController.text = place.postalCode ?? '';
      _cityController.text = place.locality ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Post Work'),
      body: BlocConsumer<WorkRequestCubit, WorkRequestState>(
        listener: (context, state) {
          if (state is WorkRequestSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Work Request Posted Successfully")),
            );
            Navigator.pop(context); // go back after success
          } else if (state is WorkRequestError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Date picker
                  CommonComponents.defaultTextField(
                    context,
                    controller: _dateController,
                    title: "Scheduled Date",
                    hintText: "Select Date",
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        _dateController.text =
                            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                      }
                    },
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Scheduled Date is required'
                        : null,
                  ),
                  AppSizes.vSpace(16),

                  // Title
                  CommonComponents.defaultTextField(
                    context,
                    controller: _titleController,
                    title: "Title",
                    hintText: "Enter Work Title",
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Title is required'
                        : null,
                  ),
                  AppSizes.vSpace(16),

                  // Description
                  CommonComponents.defaultTextField(
                    context,
                    controller: _descriptionController,
                    title: "Description",
                    hintText: "Enter Work Description",
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Description is required'
                        : null,
                  ),
                  AppSizes.vSpace(16),

                  // City
                  CommonComponents.defaultTextField(
                    context,
                    controller: _cityController,
                    title: "City",
                    hintText: "Enter City",
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'City is required'
                        : null,
                  ),
                  AppSizes.vSpace(16),

                  // Postal Code
                  CommonComponents.defaultTextField(
                    context,
                    controller: _postalCodeController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    title: "Postal Code",
                    hintText: "Enter Postal Code",
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Postal Code is required'
                        : null,
                  ),
                  AppSizes.vSpace(80),
                ],
              ),
            ),
          );
        },
      ),

      // Submit Button
      bottomSheet: BlocBuilder<WorkRequestCubit, WorkRequestState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: CustomizedButton(
              label: 'Post Work',
              isLoading: state is WorkRequestLoading,
              style: txt_15_500.copyWith(color: AppColor.white),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final requestBody = {
                    "title": _titleController.text,
                    "description": _descriptionController.text,
                    "workTypeId": widget.cetrgoryId,
                    "priority": "HIGH",
                    "status": "PENDING_ADMIN_REVIEW",
                    "scheduledDate": _dateController.text,
                    "address": {
                      "city": _cityController.text,
                      "postalCode": _postalCodeController.text,
                    },
                  };

                  context.read<WorkRequestCubit>().createWorkRequest(
                    context,
                    requestBody,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
