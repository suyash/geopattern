import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// https://github.com/jasonlong/geo_pattern/blob/master/lib/geo_pattern/structure_generators/hexagons_generator.rb
///
/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/hexagons.png
class Hexagons extends Pattern {
  final double side;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;
  final double _hexWidth;
  final double _hexHeight;

  Hexagons(
      {required this.side,
      required this.nx,
      required this.ny,
      required this.fillColors,
      required this.strokeColor})
      : assert(fillColors.length == nx * ny),
        _hexWidth = side * 2,
        _hexHeight = side * sqrt(3);

  Hexagons.fromHash(String hash)
      : assert(hash.length == 40),
        side = int.parse(hash[0], radix: 16) / 16.0 * 30 + 8,
        nx = 6,
        ny = 6,
        fillColors = hash.split("").map((String c) {
          final v = int.parse(c, radix: 16);
          final g = 50 + (v % 1) * 150;
          return Color.fromARGB(((v / 16.0) * 100 + 50).round(), g, g, g);
        }).toList(),
        strokeColor = Color.fromARGB(50, 0, 0, 0),
        _hexWidth = (int.parse(hash[0], radix: 16) / 16.0 * 30 + 8) * 2,
        _hexHeight = (int.parse(hash[0], radix: 16) / 16.0 * 30 + 8) * sqrt(3);

  void paint(Canvas canvas, Offset offset) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.strokeColor;

    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final dy = _hexHeight * y + (x % 2) * (_hexHeight / 2);

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];

        final hex = _createHexagon(Offset(
            offset.dx + x * 1.5 * side - _hexWidth / 2,
            offset.dy + dy - _hexHeight / 2));
        canvas.drawPath(hex, fillPaint);
        canvas.drawPath(hex, strokePaint);

        // NOTE: not doing edge tiling for now
      }
    }
  }

  Path _createHexagon(Offset offset) {
    return Path()
      ..moveTo(offset.dx + 0, offset.dy + _hexHeight / 2)
      ..lineTo(offset.dx + side / 2, offset.dy + 0)
      ..lineTo(offset.dx + (3 * side) / 2, offset.dy + 0)
      ..lineTo(offset.dx + side * 2, offset.dy + _hexHeight / 2)
      ..lineTo(offset.dx + (3 * side) / 2, offset.dy + 2 * _hexHeight / 2)
      ..lineTo(offset.dx + side / 2, offset.dy + 2 * _hexHeight / 2)
      ..lineTo(offset.dx + 0, offset.dy + _hexHeight / 2);
  }

  Size get size => Size((_hexWidth + side) * nx / 2, _hexHeight * ny);
}
