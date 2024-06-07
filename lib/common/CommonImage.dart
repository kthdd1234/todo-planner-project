import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

// class CommonImage extends StatelessWidget {
//   CommonImage({super.key, required this.unit8List, required this.height});

//   Uint8List unit8List;
//   double height;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(5),
//       child: Image.memory(
//         unit8List,
//         fit: BoxFit.cover,
//         width: double.maxFinite,
//         height: height,
//         cacheHeight: height.cacheSize(context),
//         frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//           if (wasSynchronouslyLoaded) return child;

//           return frame != null
//               ? child
//               : Shimmer.fromColors(
//                   baseColor: const Color.fromRGBO(240, 240, 240, 1),
//                   highlightColor: Colors.white,
//                   child: Container(
//                     width: double.infinity,
//                     height: height,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.grey,
//                     ),
//                   ),
//                 );
//         },
//       ),
//     );
//     ;
//   }
// }

class CommonImage extends StatelessWidget {
  CommonImage({
    super.key,
    required this.xFile,
    required this.height,
    required this.onTap,
  });

  XFile xFile;
  double height;
  Function(XFile) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(xFile),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.file(
          File(xFile.path),
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: height,
          cacheHeight: height.cacheSize(context),
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;

            return frame != null
                ? child
                : Shimmer.fromColors(
                    baseColor: const Color.fromRGBO(240, 240, 240, 1),
                    highlightColor: Colors.white,
                    child: Container(
                      width: double.infinity,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}
