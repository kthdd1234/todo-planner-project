import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold({
    super.key,
    required this.body,
    this.appBarInfo,
    this.bottomNavigationBar,
    this.onFloatingActionButton,
    this.resizeToAvoidBottomInset,
  });

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;
  bool? resizeToAvoidBottomInset;
  Function()? onFloatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarInfo != null
          ? AppBar(
              iconTheme: const IconThemeData(
                color: themeColor,
              ),
              title: CommonText(text: appBarInfo!.title, fontSize: 20),
              centerTitle: appBarInfo!.isCenter,
              actions: appBarInfo!.actions,
              backgroundColor: Colors.transparent,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: onFloatingActionButton != null
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              elevation: 0,
              backgroundColor: Colors.indigo.shade200,
              mini: true,
              onPressed: onFloatingActionButton,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
