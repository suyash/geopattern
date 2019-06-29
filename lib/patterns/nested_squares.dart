import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

/// A nx x ny grid of a smaller square inside a larger square
class NestedSquares extends Pattern {
  final double side;
  final double outerside;
  final int nx;
  final int ny;
  final List<Color> strokeColors;

  NestedSquares(
      {@required this.side,
      @required this.outerside,
      @required this.nx,
      @required this.ny,
      @required this.strokeColors})
      : assert(strokeColors.length == nx * ny),
        assert(outerside > side);

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

  get size => Size(nx * (2 * side + outerside), ny * (2 * side + outerside));
}
