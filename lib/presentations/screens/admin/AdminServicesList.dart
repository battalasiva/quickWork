import 'package:flutter/material.dart';
import 'package:quickWork/core/common/elements/CustomizedButton.dart';
import 'package:quickWork/core/common/elements/textInput.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';
import 'package:quickWork/core/common/elements/top_bar.dart'; // Assuming you have TopBar here

class Adminserviceslist extends StatefulWidget {
  const Adminserviceslist({super.key});

  @override
  State<Adminserviceslist> createState() => _AdminserviceslistState();
}

class _AdminserviceslistState extends State<Adminserviceslist> {
  final List<String> services = [
    "Plumbing",
    "Electrician",
    "Cleaning",
    "Carpentry",
  ];

  final TextEditingController _serviceController = TextEditingController();
  int? editingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Manage Services'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColor.primaryColor3,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                services[index],
                style: txt_15_500.copyWith(color: AppColor.black),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: AppColor.black),
                onPressed: () {
                  editingIndex = index;
                  _serviceController.text = services[index];
                  _openBottomSheet(context, isEdit: true);
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          editingIndex = null;
          _serviceController.clear();
          _openBottomSheet(context, isEdit: false);
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

  void _openBottomSheet(BuildContext context, {required bool isEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
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
                isEdit ? "Edit Service" : "Add Service",
                style: txt_15_500.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),
              TextInputWidget(
                controller: _serviceController,
                hint: 'Enter Service Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Service name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomizedButton(
                label: isEdit ? "Update Service" : "Add Service",
                isLoading: false,
                style: txt_15_500.copyWith(color: AppColor.white),
                onPressed: () {
                  if (_serviceController.text.trim().isEmpty) return;
                  setState(() {
                    if (isEdit && editingIndex != null) {
                      services[editingIndex!] = _serviceController.text.trim();
                    } else {
                      services.add(_serviceController.text.trim());
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
