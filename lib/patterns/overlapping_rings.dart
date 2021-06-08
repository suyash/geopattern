import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/overlapping_rings.png
class OverlappingRings extends Pattern {
  final double radius;
  final double strokeWidth;
  final int nx;
  final int ny;
  final List<Color> strokeColors;

  OverlappingRings(
      {required this.radius,
      required this.strokeWidth,
      required this.nx,
      required this.ny,
      required this.strokeColors})
      : assert(strokeColors.length == nx * ny);

  OverlappingRings.fromHash(String hash)
      : assert(hash.length == 40),
        radius = int.parse(hash[0], radix: 16) / 16.0 * 50 + 30,
        strokeWidth = (int.parse(hash[0], radix: 16) / 16.0 * 50 + 30) / 5,
        nx = 6,
        ny = 6,
        strokeColors = hash.split("").map((String c) {
          final v = int.parse(c, radix: 16);
          final g = 50 + (v % 1) * 150;
          return Color.fromARGB(((v / 16.0) * 100 + 50).round(), g, g, g);
        }).toList();

  void paint(Canvas canvas, Offset offset) {
    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final cx = radius * x;
        final cy = radius * y;

        final fillPaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = strokeColors[i]
          ..strokeWidth = strokeWidth;

        canvas.drawCircle(Offset(offset.dx + cx, offset.dy + cy),
            radius - strokeWidth / 2, fillPaint);

        // NOTE: not doing boundaries for now
      }
    }
  }

  Size get size => Size(radius * nx, radius * ny);
}
