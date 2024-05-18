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
  });

  TextEditingController controller;
  String hintText;
  int maxLength;
  bool? autofocus;
  TextInputAction? textInputAction;
  Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      autofocus: autofocus == true,
      maxLength: maxLength,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: themeColor,
          ),
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
    );
  }
}
