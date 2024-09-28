// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:project/common/CommonNull.dart';
// import 'package:project/page/ImageSlidePage.dart';
// import 'package:project/page/MemoSettingPage.dart';
// import 'package:project/util/func.dart';
// import 'package:project/widget/memo/MemoImage.dart';

// class SearchImage extends StatelessWidget {
//   SearchImage({super.key, required this.uint8ListList});

//   List<Uint8List>? uint8ListList;

//   @override
//   Widget build(BuildContext context) {
//     onImage(Uint8List uint8List) {
//       Navigator.push(
//         context,
//         MaterialPageRoute<void>(
//           builder: (BuildContext context) => ImageSlidePage(
//             curIndex: uint8ListList!.indexOf(uint8List),
//             uint8ListList: uint8ListList!,
//           ),
//         ),
//       );
//     }

//     return uint8ListList != null && isSearchCategory('image')
//         ? Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child:
//                 MemoImage(uint8ListList: uint8ListList ?? [], onImage: onImage),
//           )
//         : const CommonNull();
//   }
// }
