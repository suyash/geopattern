import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

class OverlappingCircles extends Pattern {
  final double radius;
  final int nx;
  final int ny;
  final List<Color> fillColors;

  OverlappingCircles(
      {@required this.radius,
      @required this.nx,
      @required this.ny,
      @required this.fillColors})
      : assert(fillColors.length == nx * ny);

  void paint(Canvas canvas, Offset offset) {
    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final cx = radius * x;
        final cy = radius * y;

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];

        canvas.drawCircle(
            Offset(offset.dx + cx, offset.dy + cy), radius, fillPaint);

        // NOTE: not doing boundaries for now
      }
    }
  }

  get size => Size(radius * nx, radius * ny);
}
