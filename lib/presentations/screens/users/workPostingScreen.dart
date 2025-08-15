import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/common/elements/CustomizedButton.dart';
import 'package:quickWork/core/common/elements/commonFields.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';

class Workpostingscreen extends StatefulWidget {
  const Workpostingscreen({super.key});

  @override
  State<Workpostingscreen> createState() => _WorkpostingscreenState();
}

class _WorkpostingscreenState extends State<Workpostingscreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // Dropdown selections
  String? _selectedWorkId;
  String? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Post Work'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Title
              CommonComponents.defaultTextField(
                context,
                controller: _titleController,
                title: "Title",
                hintText: "Enter Work Title",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              CommonComponents.defaultTextField(
                context,
                controller: _descriptionController,
                title: "Description",
                hintText: "Enter Work Description",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Work ID dropdown
              CommonComponents.defaultDropdownSearch<String>(
                context,
                title: "Work Type",
                hintText: "Select Work Type",
                items: (filter, _) async {
                  await Future.delayed(const Duration(milliseconds: 300));
                  return ["Carpentry", "Electrician", "Plumber"];
                },
                itemAsString: (String u) => u,
                selectedItem: _selectedWorkId,
                onChanged: (String? value) {
                  setState(() {
                    _selectedWorkId = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Work ID is required' : null,
              ),
              const SizedBox(height: 16),

              // Priority dropdown
              CommonComponents.defaultDropdownSearch<String>(
                context,
                title: "Priority",
                hintText: "Select Priority",
                items: (filter, _) async {
                  await Future.delayed(const Duration(milliseconds: 300));
                  return ["Low", "Medium", "High"];
                },
                itemAsString: (String u) => u,
                selectedItem: _selectedPriority,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPriority = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Priority is required' : null,
              ),
              const SizedBox(height: 16),

              // Date picker
              CommonComponents.defaultTextField(
                context,
                controller: _dateController,
                title: "Date",
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Date is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 80), // Space for bottom sheet
            ],
          ),
        ),
      ),

      // Bottom sheet with submit button
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: CustomizedButton(
          label: 'Post Work',
          isLoading: false, // set loading state here if needed
          style: txt_15_500.copyWith(color: AppColor.white),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Submit form
              print("Title: ${_titleController.text}");
              print("Description: ${_descriptionController.text}");
              print("Work ID: $_selectedWorkId");
              print("Priority: $_selectedPriority");
              print("Date: ${_dateController.text}");
            }
          },
        ),
      ),
    );
  }
}
