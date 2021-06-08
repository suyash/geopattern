import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// A nx x ny grid of a smaller square inside a larger square
///
/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/nested_squares.png
class NestedSquares extends Pattern {
  final double side;
  final double outerside;
  final int nx;
  final int ny;
  final List<Color> strokeColors;

  NestedSquares(
      {required this.side,
      required this.outerside,
      required this.nx,
      required this.ny,
      required this.strokeColors})
      : assert(strokeColors.length == nx * ny),
        assert(outerside > side);

  NestedSquares.fromHash(String hash)
      : assert(hash.length == 40),
        side = int.parse(hash[0], radix: 16) / 16.0 * 5 + 4,
        outerside = (int.parse(hash[0], radix: 16) / 16.0 * 5 + 4) * 7,
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

        final strokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = this.strokeColors[i]
          ..strokeWidth = side;

        final rect = Rect.fromLTWH(
            x * (2 * side + outerside) + side / 2 + offset.dx,
            y * (2 * side + outerside) + side / 2 + offset.dy,
            outerside,
            outerside);

        canvas.drawRect(rect, strokePaint);

        final outerStrokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = this.strokeColors[i]
          ..strokeWidth = side;

        final outerRect = Rect.fromLTWH(
            x * (2 * side + outerside) + side * 2.5 + offset.dx,
            y * (2 * side + outerside) + side * 2.5 + offset.dy,
            side * 3,
            side * 3);

        canvas.drawRect(outerRect, outerStrokePaint);
      }
    }
  }

  Size get size =>
      Size(nx * (2 * side + outerside), ny * (2 * side + outerside));
}
