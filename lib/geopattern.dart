library geopattern;

import 'package:flutter/widgets.dart';

import 'patterns/pattern.dart';

class FullPainter extends CustomPainter {
  Color background;
  Pattern pattern;

  FullPainter(this.pattern, this.background);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(background, BlendMode.color);
    for (var i = 0.0; i < size.height; i += pattern.height) {
      for (var j = 0.0; j < size.width; j += pattern.width) {
        pattern.paint(canvas, i, j);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
