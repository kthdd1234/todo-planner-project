import 'package:flutter/material.dart';
import 'package:project/util/constants.dart';

class CommonTextFormField extends StatelessWidget {
  CommonTextFormField({
    super.key,
    required this.hintText,
    required this.maxLength,
    required this.onEditingComplete,
    required this.controller,
    this.autofocus,
    this.textInputAction,
    this.focusNode,
    this.textBgColor,
    this.onChanged,
  });

  FocusNode? focusNode;
  TextEditingController controller;
  String hintText;
  int maxLength;
  bool? autofocus;
  TextInputAction? textInputAction;
  Color? textBgColor;
  Function() onEditingComplete;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      textInputAction: textInputAction,
      autofocus: autofocus == true,
      maxLength: maxLength,
      style:
          textBgColor != null ? TextStyle(backgroundColor: textBgColor) : null,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: textColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );
  }
}
