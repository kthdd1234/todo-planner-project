import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';

class CommonModalSheet extends StatelessWidget {
  CommonModalSheet({
    super.key,
    this.title,
    this.isBack,
    required this.height,
    required this.child,
  });

  String? title;
  double height;
  bool? isBack;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      height: height,
      isRadius: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              title != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isBack == true
                            ? InkWell(
                                onTap: () => navigatorPop(context),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 15, right: 15),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: textColor,
                                    size: 16,
                                  ),
                                ),
                              )
                            : const CommonNull(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: CommonText(
                            text: title!,
                            fontSize: 15,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        isBack == true
                            ? const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.transparent,
                                  size: 16,
                                ),
                              )
                            : const CommonNull(),
                      ],
                    )
                  : const CommonNull(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
