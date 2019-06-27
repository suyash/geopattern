import 'dart:math';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// https://github.com/jasonlong/geo_pattern/blob/master/lib/geo_pattern/structure_generators/hexagons_generator.rb
class Hexagons extends Pattern {
  final double size;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;
  final double _hexWidth;
  final double _hexHeight;

  Hexagons(
      {@required this.size,
      @required this.nx,
      @required this.ny,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == nx * ny),
        _hexWidth = size * 2,
        _hexHeight = size * sqrt(3);

  void paint(Canvas canvas, double top, double left) {
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
            left + x * 1.5 * size - _hexWidth / 2, top + dy - _hexHeight / 2));
        canvas.drawPath(hex, fillPaint);
        canvas.drawPath(hex, strokePaint);

        // NOTE: not doing edge tiling for now
      }
    }
  }

  Path _createHexagon(Offset offset) {
    return Path()
      ..moveTo(offset.dx + 0, offset.dy + _hexHeight / 2)
      ..lineTo(offset.dx + size / 2, offset.dy + 0)
      ..lineTo(offset.dx + (3 * size) / 2, offset.dy + 0)
      ..lineTo(offset.dx + size * 2, offset.dy + _hexHeight / 2)
      ..lineTo(offset.dx + (3 * size) / 2, offset.dy + 2 * _hexHeight / 2)
      ..lineTo(offset.dx + size / 2, offset.dy + 2 * _hexHeight / 2)
      ..moveTo(offset.dx + 0, offset.dy + _hexHeight / 2);
  }

  get width {
    return (_hexWidth + size) * nx / 2;
  }

  get height {
    return _hexHeight * ny;
  }
}
