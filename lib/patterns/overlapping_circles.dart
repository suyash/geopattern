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

  OverlappingCircles.fromHash(String hash)
      : assert(hash.length == 40),
        radius = int.parse(hash[0], radix: 16) / 16.0 * 50 + 30,
        nx = 6,
        ny = 6,
        fillColors = hash.split("").map((String c) {
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
