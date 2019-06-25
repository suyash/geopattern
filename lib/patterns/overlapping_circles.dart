import 'package:flutter/widgets.dart';

import 'pattern.dart';

class OverlappingCircles extends Pattern {
  final double radius;
  final int nw;
  final int nh;
  final List<Color> fillColors;

  OverlappingCircles(
      {@required this.radius,
      @required this.nw,
      @required this.nh,
      @required this.fillColors})
      : assert(fillColors.length == nw * nh);

  void paint(Canvas canvas, double top, double left) {
    for (var y = 0; y < nh; y++) {
      for (var x = 0; x < nw; x++) {
        final i = y * nw + x;

        final cx = radius * x;
        final cy = radius * y;

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];

        canvas.drawCircle(Offset(left + cx, top + cy), radius, fillPaint);

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
