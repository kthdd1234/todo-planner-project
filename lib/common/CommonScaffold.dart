import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold({
    super.key,
    required this.body,
    this.appBarInfo,
    this.bottomNavigationBar,
  });

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBarInfo != null
          ? AppBar(
              title: CommonText(text: appBarInfo!.title),
              centerTitle: appBarInfo!.centerTitle,
              actions: appBarInfo!.actions,
            )
          : null,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: body,
      )),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
