import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';

class CommonModalSheet extends StatelessWidget {
  CommonModalSheet({
    super.key,
    required this.title,
    required this.buttonText,
    required this.child,
    required this.onCompleted,
  });

  String title, buttonText;
  Widget child;
  Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      isRadius: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CommonText(text: title),
              CommonSpace(height: 15),
              Expanded(child: CommonContainer(child: child)),
              CommonSpace(height: 15),
              CommonButton(
                text: buttonText,
                textColor: Colors.white,
                buttonColor: themeColor,
                verticalPadding: 15,
                borderRadius: 100,
                onTap: onCompleted,
              )
            ],
          ),
        ),
      ),
    );
  }
}
