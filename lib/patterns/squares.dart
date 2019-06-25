import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// A nx x ny repeating grid of squares
class Squares extends Pattern {
  final double size;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  Squares(
      {@required this.size,
      @required this.nx,
      @required this.ny,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == nx * ny);

  void paint(Canvas canvas, double top, double left) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.strokeColor;
    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * 6 + x;
        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];
        final rect = Rect.fromLTWH(x * size + left, y * size + top, size, size);
        canvas.drawRect(rect, strokePaint);
        canvas.drawRect(rect, fillPaint);
      }
    }
  }

  get width {
    return nx * size;
  }

  get height {
    return ny * size;
  }
}
