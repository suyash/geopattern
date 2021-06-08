library geopattern_flutter;

import 'package:flutter/widgets.dart';

import 'patterns/pattern.dart';

/// A CustomPainter that takes a single pattern and draws it across the entire canvas.
class FullPainter extends CustomPainter {
  Color background;
  Pattern pattern;

  FullPainter({required this.pattern, required this.background});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(background, BlendMode.color);
    for (var i = 0.0; i < size.height; i += pattern.size.height) {
      for (var j = 0.0; j < size.width; j += pattern.size.width) {
        pattern.paint(canvas, Offset(j, i));
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
