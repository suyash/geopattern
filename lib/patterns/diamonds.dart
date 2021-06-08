import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// A grid of diamonds with each extending w units wide and h units high
///
/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/diamonds.png
class Diamonds extends Pattern {
  final double w;
  final double h;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  Diamonds(
      {required this.w,
      required this.h,
      required this.nx,
      required this.ny,
      required this.fillColors,
      required this.strokeColor})
      : assert(fillColors.length == nx * ny);

  Diamonds.fromHash(String hash)
      : assert(hash.length == 40),
        w = int.parse(hash[0], radix: 16) / 16.0 * 50 + 30,
        h = int.parse(hash[1], radix: 16) / 16.0 * 50 + 30,
        nx = 6,
        ny = 6,
        fillColors = hash.split("").map((String c) {
          final v = int.parse(c, radix: 16);
          final g = 50 + (v % 1) * 150;
          return Color.fromARGB(((v / 16.0) * 100 + 50).round(), g, g, g);
        }).toList(),
        strokeColor = Color.fromARGB(50, 0, 0, 0);

  void paint(Canvas canvas, Offset offset) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.strokeColor;

    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];

        final dx = y % 2 == 1 ? w / 2 : 0;

        final diamond = _createDiamond(Offset(
            offset.dx + dx + x * w - w / 2, offset.dy + (y - 1) * h / 2));
        canvas.drawPath(diamond, strokePaint);
        canvas.drawPath(diamond, fillPaint);

        // NOTE: not painting edges for now
      }
    }
  }

  Path _createDiamond(Offset offset) {
    return Path()
      ..moveTo(offset.dx + w / 2.0, offset.dy)
      ..lineTo(offset.dx + w, offset.dy + h / 2.0)
      ..lineTo(offset.dx + w / 2.0, offset.dy + h)
      ..lineTo(offset.dx, offset.dy + h / 2.0)
      ..lineTo(offset.dx + w / 2.0, offset.dy);
  }

  Size get size => Size(w * nx, (h * ny / 2).ceil() * 1.0);
}
