import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

/// A nw x nh repeating grid of circles
class ConcentricCircles extends Pattern {
  final double radius;
  final double strokeWidth;
  final int nx;
  final int ny;
  final List<Color> strokeColors;
  final List<Color> fillColors;

  ConcentricCircles(
      {@required this.radius,
      @required this.strokeWidth,
      @required this.nx,
      @required this.ny,
      @required this.strokeColors,
      @required this.fillColors})
      : assert(strokeColors.length == nx * ny),
        assert(fillColors.length == nx * ny);

  void paint(Canvas canvas, Offset offset) {
    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final cx = (radius + strokeWidth) * (x + 0.5);
        final cy = (radius + strokeWidth) * (y + 0.5);

        final strokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = this.strokeColors[i]
          ..strokeWidth = strokeWidth;
        canvas.drawCircle(
            Offset(offset.dx + cx, offset.dy + cy), radius / 2, strokePaint);

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];
        canvas.drawCircle(
            Offset(offset.dx + cx, offset.dy + cy), radius / 4, fillPaint);
      }
    }
  }

  get size => Size((radius + strokeWidth) * nx, (radius + strokeWidth) * ny);
}
