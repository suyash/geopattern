import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// A nw x nh repeating grid of circles
///
/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/concentric_circles.png
class ConcentricCircles extends Pattern {
  final double radius;
  final double strokeWidth;
  final int nx;
  final int ny;
  final List<Color> strokeColors;
  final List<Color> fillColors;

  ConcentricCircles(
      {required this.radius,
      required this.strokeWidth,
      required this.nx,
      required this.ny,
      required this.strokeColors,
      required this.fillColors})
      : assert(strokeColors.length == nx * ny),
        assert(fillColors.length == nx * ny);

  ConcentricCircles.fromHash(String hash)
      : assert(hash.length == 40),
        radius = int.parse(hash[0], radix: 16) / 16.0 * 50 + 10,
        strokeWidth = (int.parse(hash[0], radix: 16) / 16.0 * 50 + 10) / 5,
        nx = 6,
        ny = 6,
        fillColors = hash.split("").map((String c) {
          final v = int.parse(c, radix: 16);
          final g = 50 + (v % 1) * 150;
          return Color.fromARGB(((v / 16.0) * 100 + 50).round(), g, g, g);
        }).toList(),
        strokeColors = hash.split("").map((String c) {
          final v = int.parse(c, radix: 16);
          final g = 50 + (v % 1) * 150;
          return Color.fromARGB(((v / 16.0) * 100 + 50).round(), g, g, g);
        }).toList();

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

  Size get size =>
      Size((radius + strokeWidth) * nx, (radius + strokeWidth) * ny);
}
