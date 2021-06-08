import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/chevrons.png
class Chevrons extends Pattern {
  final double side;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  Chevrons(
      {required this.side,
      required this.nx,
      required this.ny,
      required this.fillColors,
      required this.strokeColor})
      : assert(fillColors.length == nx * ny);

  Chevrons.fromHash(String hash)
      : assert(hash.length == 40),
        side = int.parse(hash[0], radix: 16) / 16.0 * 50 + 30,
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
      ..color = this.strokeColor
      ..strokeWidth = 1;

    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];

        final leftChevron = _createChevronLeft(Offset(
            offset.dx + x * side, offset.dy + (2 * side * y) / 3 - side / 2));
        final rightChevron = _createChevronRight(Offset(
            offset.dx + x * side, offset.dy + (2 * side * y) / 3 - side / 2));

        canvas.drawPath(leftChevron, strokePaint);
        canvas.drawPath(leftChevron, fillPaint);
        canvas.drawPath(rightChevron, strokePaint);
        canvas.drawPath(rightChevron, fillPaint);

        // NOTE: not filling gaps in topmost row for now
      }
    }
  }

  Path _createChevronLeft(Offset offset) {
    final e = (side * 2) / 3;
    return Path()
      ..moveTo(offset.dx, offset.dy)
      ..lineTo(offset.dx + side / 2, offset.dy + side - e)
      ..lineTo(offset.dx + side / 2, offset.dy + side)
      ..lineTo(offset.dx, offset.dy + e)
      ..lineTo(offset.dx, offset.dy);
  }

  Path _createChevronRight(Offset offset) {
    final e = (side * 2) / 3;
    return Path()
      ..moveTo(offset.dx + side / 2, offset.dy + side - e)
      ..lineTo(offset.dx + side, offset.dy)
      ..lineTo(offset.dx + side, offset.dy + e)
      ..lineTo(offset.dx + side / 2, offset.dy + side)
      ..lineTo(offset.dx + side / 2, offset.dy + side - e);
  }

  Size get size => Size(side * nx, ((side * ny * 2) / 3).ceil() * 1.0);
}
