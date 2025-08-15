import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';

class CustomDropDownSearchField extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  final Map<String, dynamic>? selectedUser;
  final Function(Map<String, dynamic>?) onUserSelected;
  final String? label;

  const CustomDropDownSearchField({
    Key? key,
    required this.users,
    required this.onUserSelected,
    this.selectedUser,
    this.label,
  }) : super(key: key);

  @override
  State<CustomDropDownSearchField> createState() =>
      _CustomDropDownSearchFieldState();
}

class _CustomDropDownSearchFieldState extends State<CustomDropDownSearchField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.selectedUser != null ? widget.selectedUser!['name'] : '',
    );
  }

  @override
  void didUpdateWidget(covariant CustomDropDownSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedUser != oldWidget.selectedUser) {
      _controller.text = widget.selectedUser != null
          ? widget.selectedUser!['name']
          : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              widget.label!,
              style: txt_14_600.copyWith(color: AppColor.black2),
            ),
          ),
        DropDownSearchField<Map<String, dynamic>>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
            autofocus: false,
            style: DefaultTextStyle.of(
              context,
            ).style.copyWith(fontStyle: FontStyle.normal, fontSize: 16),
            decoration: InputDecoration(
              hintText: "Select Item..",
              suffixIcon: const Icon(Icons.arrow_drop_down, size: 30),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
          ),
          suggestionsCallback: (pattern) async {
            if (pattern.isEmpty) {
              return widget.users;
            } else {
              return widget.users
                  .where(
                    (user) => user['name'].toString().toLowerCase().contains(
                      pattern.toLowerCase(),
                    ),
                  )
                  .toList();
            }
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(suggestion['name']),
            );
          },
          onSuggestionSelected: (suggestion) {
            _controller.text = suggestion['name'];
            widget.onUserSelected(suggestion);
          },
          displayAllSuggestionWhenTap: true,
          isMultiSelectDropdown: false,
        ),
      ],
    );
  }
}
