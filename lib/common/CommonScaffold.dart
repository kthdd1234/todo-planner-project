import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/widget/button/SpeedDialButton.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold({
    super.key,
    required this.body,
    this.appBarInfo,
    this.bottomNavigationBar,
    this.isFab,
    this.resizeToAvoidBottomInset,
  });

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;
  bool? resizeToAvoidBottomInset, isFab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarInfo != null
          ? AppBar(
              title: CommonText(text: appBarInfo!.title, fontSize: 20),
              centerTitle: appBarInfo!.isCenter,
              actions: appBarInfo!.actions,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: isFab == true ? const SpeedDialButton() : null,
    );
  }
}
