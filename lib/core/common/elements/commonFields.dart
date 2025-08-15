import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickWork/core/constants/app_sizes.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/core/constants/text_styles.dart';

class CommonComponents {
  static Column defaultTextField(
    context, {
    TextEditingController? controller,
    bool? isMultiline = false,
    bool? showTitle = true,
    required String? title,
    String? initialValue,
    String? hintText,
    String? errorText,
    bool? readOnly = false,
    bool? enable = true,
    bool? filled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? suffixText = '',
    int? maxLength,
    int? maxLines,
    bool? obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    TextCapitalization? textCapitalization,
    InputDecoration? decoration,
    validator,
    void Function(String?)? onSaved,
    void Function()? onTap,
    void Function()? onEditingComplete,
    void Function(String)? onChange,
    void Function(String)? onFieldSubmitted,
    void Function(PointerDownEvent)? onTapOutside,
    bool isRedStar = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle ?? true)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title ?? '',
                    style: txt_13_500.copyWith(color: AppColor.black1),
                  ),
                  if (isRedStar)
                    Text(
                      ' *',
                      style: TextStyle(
                        color: AppColor.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        TextFormField(
          scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          autofocus: false,
          maxLength: maxLength,
          maxLines: obscureText! ? 1 : maxLines,
          readOnly: readOnly!,
          enabled: enable,
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          focusNode: focusNode,
          textInputAction: textInputAction,
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatters,
          cursorColor: filled!
              ? AppColor.primaryColor1
              : AppColor.primaryColor3,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: filled ? AppColor.primaryColor1 : AppColor.primaryColor3,
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: !filled
                  ? AppColor.primaryColor3
                  : const Color.fromRGBO(153, 153, 169, 1),
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                    child: prefixIcon,
                  )
                : null,
            suffixText: suffixText!,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: suffixIcon,
                  )
                : null,
            filled: true,
            fillColor: readOnly! ? AppColor.greyBackground : AppColor.white,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: filled
                    ? const Color.fromRGBO(153, 153, 169, 1)
                    : AppColor.primaryColor3,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: filled ? AppColor.grey : AppColor.primaryColor3,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromRGBO(153, 153, 169, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(10),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 10,
              minWidth: 10,
              maxHeight: 20,
              maxWidth: 60,
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 10,
              minWidth: 10,
              maxHeight: 20,
              maxWidth: 40,
            ),
          ),
          onTapOutside: onTapOutside,
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onTap: onTap,
          validator: validator,
          onEditingComplete: onEditingComplete,
        ),
      ],
    );
  }

  static Column defaultSearchTextField(
    context, {
    TextEditingController? controller,
    String? initialValue,
    String? hintText,
    String? errorText,
    bool? readOnly = false,
    bool? enable = true,
    bool? filled = true,
    Icon? prefixIcon,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    TextCapitalization? textCapitalization,
    InputDecoration? decoration,
    validator,
    void Function(String?)? onSaved,
    void Function()? onTap,
    void Function()? onEditingComplete,
    void Function(String)? onChange,
    void Function(String)? onFieldSubmitted,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: readOnly!,
          enabled: enable,
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          focusNode: focusNode,
          textInputAction: textInputAction,
          initialValue: initialValue,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatters,
          autofocus: false,
          cursorColor: AppColor.primaryColor1,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            counterText: '',
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.primaryColor1,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.search, color: AppColor.primaryColor1),
            ),
            filled: true,
            fillColor: AppColor.greyBackground,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 10,
              minWidth: 10,
              maxHeight: 20,
              maxWidth: 60,
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 10,
              minWidth: 10,
              maxHeight: 20,
              maxWidth: 40,
            ),
          ),
          onTapOutside: onTapOutside,
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
        ),
      ],
    );
  }

  static Column defaultDropdownSearch<T>(
    context, {
    Key? key,
    Icon? prefixIcon,
    String? title = '',
    required String? hintText,
    bool? enabled,
    Color? filledColor,
    validator,
    Future<List<T>> Function(String, LoadProps?)? items,
    compareFn,
    disableItemFn,
    itemAsString,
    selectedItem,
    onChanged,
    itemBuilder,
    int? skip = 0,
    bool isRedStar = false,
    bool? showTitle = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle ?? true)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title ?? '',
                    style: txt_13_500.copyWith(color: AppColor.black1),
                  ),
                  if (isRedStar)
                    Text(
                      ' *',
                      style: TextStyle(
                        color: AppColor.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        DropdownSearch<T>(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          items: items,
          key: ValueKey(title),
          suffixProps: DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              iconOpened: Icon(
                Icons.arrow_drop_down,
                color: AppColor.primaryColor1,
              ),
              iconClosed: Icon(
                Icons.arrow_drop_down,
                color: AppColor.primaryColor1,
              ),
            ),
          ),
          validator: validator,
          compareFn: compareFn,
          enabled: enabled ?? true,
          dropdownBuilder: (context, selectedItem) {
            return Text(
              itemAsString != null && selectedItem != null
                  ? itemAsString(selectedItem)
                  : '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            );
          },
          decoratorProps: DropDownDecoratorProps(
            baseStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: "$hintText",
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.grey,
              ),
              contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
            ),
          ),
          popupProps: PopupPropsMultiSelection.modalBottomSheet(
            disabledItemFn: disableItemFn,
            showSelectedItems: true,
            showSearchBox: true,
            itemBuilder: itemBuilder,
            fit: FlexFit.tight,
            disableFilter: true,
            infiniteScrollProps: InfiniteScrollProps(
              loadProps: LoadProps(skip: skip ?? 0, take: 10),
              loadingMoreBuilder: (context, loadedItems) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              },
            ),
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search, color: AppColor.primaryColor1),
                filled: true,
                fillColor: AppColor.greyText2,
                hintText: 'Search Here',
                hintStyle: TextStyle(color: AppColor.black1),
              ),
            ),
            modalBottomSheetProps: ModalBottomSheetProps(
              backgroundColor: AppColor.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
            title: Container(
              height: AppSizes.height(50),
              decoration: BoxDecoration(
                color: AppColor.primaryColor1,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Center(
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor3,
                  ),
                ),
              ),
            ),
          ),
          itemAsString: itemAsString,
          selectedItem: selectedItem,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
