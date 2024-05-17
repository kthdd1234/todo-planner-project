import 'package:flutter/material.dart';
import 'package:project/util/constants.dart';

class CommonTextFormField extends StatelessWidget {
  CommonTextFormField(
      {super.key,
      required this.hintText,
      required this.maxLength,
      this.textInputAction});

  String hintText;
  int maxLength;
  TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      autofocus: true,
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
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
