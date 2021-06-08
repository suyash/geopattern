import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// https://github.com/jasonlong/geo_pattern/blob/master/lib/geo_pattern/structure_generators/octagons_generator.rb
///
/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/octagons.png
class Octagons extends Pattern {
  final double side;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  Octagons(
      {required this.side,
      required this.nx,
      required this.ny,
      required this.fillColors,
      required this.strokeColor})
      : assert(fillColors.length == nx * ny);

  Octagons.fromHash(String hash)
      : assert(hash.length == 40),
        side = int.parse(hash[0], radix: 16) / 16.0 * 20 + 20,
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

        final oct =
            _createOctagon(Offset(offset.dx + x * side, offset.dy + y * side));
        canvas.drawPath(oct, fillPaint);
        canvas.drawPath(oct, strokePaint);
      }
    }
  }

  Path _createOctagon(Offset offset) {
    return Path()
      ..moveTo(offset.dx + side / 3, offset.dy + 0)
      ..lineTo(offset.dx + 2 * side / 3, offset.dy + 0)
      ..lineTo(offset.dx + side, offset.dy + side / 3)
      ..lineTo(offset.dx + side, offset.dy + 2 * side / 3)
      ..lineTo(offset.dx + 2 * side / 3, offset.dy + side)
      ..lineTo(offset.dx + side / 3, offset.dy + side)
      ..lineTo(offset.dx + 0, offset.dy + 2 * side / 3)
      ..lineTo(offset.dx + 0, offset.dy + side / 3)
      ..lineTo(offset.dx + side / 3, offset.dy + 0);
  }

  Size get size => Size(side * nx, side * ny);
}
