import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// A nx x ny grid of a smaller square inside a larger square
class NestedSquares extends Pattern {
  final double size;
  final double outersize;
  final int nx;
  final int ny;
  final List<Color> strokeColors;

  NestedSquares(
      {@required this.size,
      @required this.outersize,
      @required this.nx,
      @required this.ny,
      @required this.strokeColors})
      : assert(strokeColors.length == nx * ny),
        assert(outersize > size);

  void paint(Canvas canvas, double top, double left) {
    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final strokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = this.strokeColors[i]
          ..strokeWidth = size;

        final rect = Rect.fromLTWH(x * (2 * size + outersize) + size / 2 + left,
            y * (2 * size + outersize) + size / 2 + top, outersize, outersize);

        canvas.drawRect(rect, strokePaint);

        final outerStrokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = this.strokeColors[i]
          ..strokeWidth = size;

        final outerRect = Rect.fromLTWH(
            x * (2 * size + outersize) + size * 2.5 + left,
            y * (2 * size + outersize) + size * 2.5 + top,
            size * 3,
            size * 3);

        canvas.drawRect(outerRect, outerStrokePaint);
      }
    }
  }

  get width {
    return nx * (2 * size + outersize);
  }

  get height {
    return ny * (2 * size + outersize);
  }
}
