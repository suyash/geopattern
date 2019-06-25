import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// A grid of diamonds with each extending w units wide and h units high
class Diamonds extends Pattern {
  final double w;
  final double h;
  final int nw;
  final int nh;
  final List<Color> fillColors;
  final Color strokeColor;

  Diamonds(
      {@required this.w,
      @required this.h,
      @required this.nw,
      @required this.nh,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == nw * nh);

  void paint(Canvas canvas, double top, double left) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.strokeColor;

    for (var y = 0; y < nh; y++) {
      for (var x = 0; x < nw; x++) {
        final i = y * nw + x;

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];

        final dx = y % 2 == 1 ? w / 2 : 0;
        final offsetx = dx + x * w - w / 2;
        final offsety = (y - 1) * h / 2;

        final diamond = _createDiamond(left + offsetx, top + offsety);
        canvas.drawPath(diamond, strokePaint);
        canvas.drawPath(diamond, fillPaint);

        // NOTE: not painting edges for now
      }
    }
  }

  Path _createDiamond(double offsetx, double offsety) {
    return Path()
      ..moveTo(offsetx + w / 2.0, offsety)
      ..lineTo(offsetx + w, offsety + h / 2.0)
      ..lineTo(offsetx + w / 2.0, offsety + h)
      ..lineTo(offsetx, offsety + h / 2.0)
      ..lineTo(offsetx + w / 2.0, offsety);
  }

  get width {
    return w * nw;
  }

  get height {
    return (h * nh / 2).ceil() * 1.0;
  }
}
