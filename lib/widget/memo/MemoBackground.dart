import 'package:flutter/material.dart';

class MemoBackground extends CustomPainter {
  MemoBackground({required this.isLight, required this.color});

  bool isLight;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = isLight ? color : const Color.fromARGB(255, 43, 43, 43);

    for (int i = 1; i < height; i++) {
      if (i % 15 == 0) {
        Path linePath = Path();
        linePath.addRect(
            Rect.fromLTRB(0, i.toDouble(), width, (i + 0.5).toDouble()));
        canvas.drawPath(linePath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
