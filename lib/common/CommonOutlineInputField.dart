import 'package:flutter/material.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';

class CommonOutlineInputField extends StatelessWidget {
  CommonOutlineInputField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onEditingComplete,
  });

  String hintText;
  TextEditingController controller;
  Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 25),
          hintText: hintText,
          hintStyle: TextStyle(color: grey.s400),
          filled: true,
          fillColor: whiteBgBtnColor,
          suffixIcon: UnconstrainedBox(
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: indigo.s200,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
