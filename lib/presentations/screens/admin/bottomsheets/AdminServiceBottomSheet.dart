import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/common/commonMethods.dart';
import 'package:quickWork/core/common/elements/commonFields.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/core/common/elements/CustomizedButton.dart';
import 'package:quickWork/core/common/elements/textInput.dart';
import 'package:quickWork/presentations/cubit/work-category/post-work/post_work_type_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/post-work/post_work_type_state.dart';

class AdminServiceBottomSheet extends StatefulWidget {
  final bool isEdit;
  final TextEditingController controller;
  final String? initialValue;
  final VoidCallback onSuccess; // 🔹 callback to refresh parent

  const AdminServiceBottomSheet({
    super.key,
    required this.isEdit,
    required this.controller,
    this.initialValue,
    required this.onSuccess,
  });

  @override
  State<AdminServiceBottomSheet> createState() =>
      _AdminServiceBottomSheetState();
}

class _AdminServiceBottomSheetState extends State<AdminServiceBottomSheet> {
  String? _selectedService;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.isEdit ? "Edit Service" : "Add Service",
            style: txt_15_500.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 16),

          /// 🔹 Text input for Service Name
          TextInputWidget(
            controller: widget.controller,
            hint: 'Enter Service Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Service name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          /// 🔹 Dropdown for Category
          CommonComponents.defaultDropdownSearch<String>(
            context,
            title: "Service Type",
            hintText: "Select Service",
            items: (filter, _) async {
              // ✅ Removed artificial delay to prevent infinite scroll
              return ServiceConstants.categories
                  .where(
                    (service) =>
                        service.toLowerCase().contains(filter.toLowerCase()),
                  )
                  .toList();
            },
            itemAsString: (String u) => u,
            selectedItem: _selectedService,
            onChanged: (String? value) {
              setState(() {
                _selectedService = value;
              });
            },
            validator: (value) =>
                value == null ? 'Service type is required' : null,
          ),

          const SizedBox(height: 20),

          /// 🔹 BlocConsumer for handling states
          BlocConsumer<PostWorkTypeCubit, PostWorkTypeState>(
            listener: (context, state) {
              if (state is PostWorkTypeSuccess) {
                Navigator.pop(context); // close sheet on success
                widget.onSuccess(); // refresh parent
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Service saved successfully")),
                );
              } else if (state is PostWorkTypeError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final isLoading = state is PostWorkTypeLoading;

              return CustomizedButton(
                label: widget.isEdit ? "Update Service" : "Add Service",
                isLoading: isLoading,
                style: txt_15_500.copyWith(color: AppColor.white),
                onPressed: () {
                  if (widget.controller.text.trim().isEmpty ||
                      _selectedService == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter name and select type"),
                      ),
                    );
                    return;
                  }

                  // ✅ Pass both "name" & "category"
                  final payload = {
                    "name": widget.controller.text.trim(),
                    "category": _selectedService!,
                  };

                  context.read<PostWorkTypeCubit>().createWorkType(
                    context,
                    payload,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
