import 'package:flutter/cupertino.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';

class ImageModalSheet extends StatelessWidget {
  const ImageModalSheet({super.key});

  button() {
    return CommonContainer(
      child: Column(
        children: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      height: 500,
      child: Column(
        children: [],
      ),
    );
  }
}
