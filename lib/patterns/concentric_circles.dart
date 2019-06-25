import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// A nw x nh repeating grid of circles
class ConcentricCircles extends Pattern {
  final double radius;
  final double strokeWidth;
  final int nw;
  final int nh;
  final List<Color> strokeColors;
  final List<Color> fillColors;

  ConcentricCircles(
      {@required this.radius,
      @required this.strokeWidth,
      @required this.nw,
      @required this.nh,
      @required this.strokeColors,
      @required this.fillColors})
      : assert(strokeColors.length == nw * nh),
        assert(fillColors.length == nw * nh);

  void paint(Canvas canvas, double top, double left) {
    for (var y = 0; y < nh; y++) {
      for (var x = 0; x < nw; x++) {
        final i = y * nw + x;

        final cx = (radius + strokeWidth) * (x + 0.5);
        final cy = (radius + strokeWidth) * (y + 0.5);

        final strokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = this.strokeColors[i]
          ..strokeWidth = strokeWidth;
        canvas.drawCircle(Offset(left + cx, top + cy), radius / 2, strokePaint);

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];
        canvas.drawCircle(Offset(left + cx, top + cy), radius / 4, fillPaint);
      }
    }
  }

  get width {
    return (radius + strokeWidth) * nw;
  }

  get height {
    return (radius + strokeWidth) * nh;
  }
}
