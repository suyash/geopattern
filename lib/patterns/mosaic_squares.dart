import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/mosaic_squares.png
class MosaicSquares extends Pattern {
  final double side;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  MosaicSquares(
      {required this.side,
      required this.nx,
      required this.ny,
      required this.fillColors,
      required this.strokeColor})
      : assert(fillColors.length == 2 * nx * ny);

  MosaicSquares.fromHash(String hash)
      : assert(hash.length == 40),
        side = int.parse(hash[0], radix: 16) / 16.0 * 10 + 15,
        nx = 4,
        ny = 4,
        fillColors = hash.substring(0, 32).split("").map((String c) {
          final v = int.parse(c, radix: 16);
          final g = 50 + (v % 1) * 150;
          return Color.fromARGB(((v / 16.0) * 100 + 50).round(), g, g, g);
        }).toList(),
        strokeColor = Color.fromARGB(50, 0, 0, 0);

  void paint(Canvas canvas, Offset offset) {
    final strokePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = this.strokeColor;

    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        if (x % 2 == 1) {
          if (y % 2 == 1) {
            final fillPaint = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i];
            _drawOuter(
                canvas,
                Offset(2 * side * x + offset.dx, 2 * side * y + offset.dy),
                strokePaint,
                fillPaint);
          } else {
            final fillPaint1 = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i];
            final fillPaint2 = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i + nx * ny];
            _drawInner(
                canvas,
                Offset(2 * side * x + offset.dx, 2 * side * y + offset.dy),
                strokePaint,
                fillPaint1,
                fillPaint2);
          }
        } else {
          if (y % 2 == 1) {
            final fillPaint1 = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i];
            final fillPaint2 = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i + nx * ny];
            _drawInner(
                canvas,
                Offset(2 * side * x + offset.dx, 2 * side * y + offset.dy),
                strokePaint,
                fillPaint1,
                fillPaint2);
          } else {
            final fillPaint = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i];
            _drawOuter(
                canvas,
                Offset(2 * side * x + offset.dx, 2 * side * y + offset.dy),
                strokePaint,
                fillPaint);
          }
        }
      }
    }
  }

  void _drawOuter(
      Canvas canvas, Offset offset, Paint strokePaint, Paint fillPaint) {
    final bottomright = Path()
      ..moveTo(offset.dx, offset.dy + side)
      ..lineTo(offset.dx + side, offset.dy + 2 * side)
      ..lineTo(offset.dx, offset.dy + 2 * side)
      ..lineTo(offset.dx, offset.dy + side);

    canvas.drawPath(bottomright, strokePaint);
    canvas.drawPath(bottomright, fillPaint);

    final bottomleft = Path()
      ..moveTo(offset.dx + 2 * side, offset.dy + side)
      ..lineTo(offset.dx + 2 * side - side, offset.dy + 2 * side)
      ..lineTo(offset.dx + 2 * side, offset.dy + 2 * side)
      ..lineTo(offset.dx + 2 * side, offset.dy + side);

    canvas.drawPath(bottomleft, strokePaint);
    canvas.drawPath(bottomleft, fillPaint);

    final topleft = Path()
      ..moveTo(offset.dx, offset.dy + side)
      ..lineTo(offset.dx + side, offset.dy + side - side)
      ..lineTo(offset.dx, offset.dy + side - side)
      ..lineTo(offset.dx, offset.dy + side);

    canvas.drawPath(topleft, strokePaint);
    canvas.drawPath(topleft, fillPaint);

    final topright = Path()
      ..moveTo(offset.dx + 2 * side, offset.dy + side)
      ..lineTo(offset.dx + 2 * side - side, offset.dy + side - side)
      ..lineTo(offset.dx + 2 * side, offset.dy + side - side)
      ..lineTo(offset.dx + 2 * side, offset.dy + side);

    canvas.drawPath(topright, strokePaint);
    canvas.drawPath(topright, fillPaint);
  }

  void _drawInner(Canvas canvas, Offset offset, Paint strokePaint,
      Paint fillPaint1, Paint fillPaint2) {
    final topleft = Path()
      ..moveTo(offset.dx + side, offset.dy)
      ..lineTo(offset.dx + side - side, offset.dy + side)
      ..lineTo(offset.dx + side, offset.dy + side)
      ..lineTo(offset.dx + side, offset.dy);

    canvas.drawPath(topleft, strokePaint);
    canvas.drawPath(topleft, fillPaint1);

    final bottomright = Path()
      ..moveTo(offset.dx + side, offset.dy + 2 * side)
      ..lineTo(offset.dx + side + side, offset.dy + 2 * side - side)
      ..lineTo(offset.dx + side, offset.dy + 2 * side - side)
      ..lineTo(offset.dx + side, offset.dy + 2 * side);

    canvas.drawPath(bottomright, strokePaint);
    canvas.drawPath(bottomright, fillPaint1);

    final topright = Path()
      ..moveTo(offset.dx + side, offset.dy)
      ..lineTo(offset.dx + side + side, offset.dy + side)
      ..lineTo(offset.dx + side, offset.dy + side)
      ..lineTo(offset.dx + side, offset.dy);

    canvas.drawPath(topright, strokePaint);
    canvas.drawPath(topright, fillPaint2);

    final bottomleft = Path()
      ..moveTo(offset.dx + side, offset.dy + 2 * side)
      ..lineTo(offset.dx + side - side, offset.dy + 2 * side - side)
      ..lineTo(offset.dx + side, offset.dy + 2 * side - side)
      ..lineTo(offset.dx + side, offset.dy + 2 * side);

    canvas.drawPath(bottomleft, strokePaint);
    canvas.drawPath(bottomleft, fillPaint2);
  }

  Size get size => Size(side * nx * 2, side * ny * 2);
}
