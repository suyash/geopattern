import 'package:flutter/widgets.dart';

import 'pattern.dart';

class OverlappingRings extends Pattern {
  final double radius;
  final double strokeWidth;
  final int nw;
  final int nh;
  final List<Color> strokeColors;

  OverlappingRings(
      {@required this.radius,
      @required this.strokeWidth,
      @required this.nw,
      @required this.nh,
      @required this.strokeColors})
      : assert(strokeColors.length == nw * nh);

  void paint(Canvas canvas, double top, double left) {
    for (var y = 0; y < nh; y++) {
      for (var x = 0; x < nw; x++) {
        final i = y * nw + x;

        final cx = radius * x;
        final cy = radius * y;

        final fillPaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = strokeColors[i]
          ..strokeWidth = strokeWidth;

        canvas.drawCircle(
            Offset(left + cx, top + cy), radius - strokeWidth / 2, fillPaint);

        // NOTE: not doing boundaries for now
      }
    }
  }

  get width {
    return radius * nw;
  }

  get height {
    return radius * nh;
  }
}
