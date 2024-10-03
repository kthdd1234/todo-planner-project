import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonImage extends StatelessWidget {
  CommonImage({
    super.key,
    required this.uint8List,
    required this.height,
    required this.onTap,
    this.radious,
    this.width,
  });

  Uint8List uint8List;
  double? width, radious;
  double height;
  Function(Uint8List) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(uint8List),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radious ?? 5),
        child: Image.memory(
          uint8List,
          fit: BoxFit.cover,
          width: width,
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
