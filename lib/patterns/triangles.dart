import 'dart:math';
import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

class Triangles extends Pattern {
  final double size;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;
  final double _trih;

  Triangles(
      {@required this.size,
      @required this.nx,
      @required this.ny,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == nx * ny),
        _trih = sqrt(3) * size / 2;

  void paint(Canvas canvas, Offset offset) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = strokeColor;
    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final off = Offset(x * size / 2 - size / 2, _trih * y);
        final triangle = x % 2 == y % 2
            ? _createInvertedTriangle(offset + off + Offset(size / 2, 0))
            : _createTriangle(offset + off);

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[y * nx + x];
        canvas.drawPath(triangle, fillPaint);
        canvas.drawPath(triangle, strokePaint);
      }
    }
  }

  Path _createTriangle(Offset offset) {
    return Path()
      ..moveTo(offset.dx + size / 2, offset.dy + 0)
      ..lineTo(offset.dx + size, offset.dy + _trih)
      ..lineTo(offset.dx + 0, offset.dy + _trih)
      ..lineTo(offset.dx + size / 2, offset.dy + 0);
  }

  Path _createInvertedTriangle(Offset offset) {
    return Path()
      ..moveTo(offset.dx + -size / 2, offset.dy + 0)
      ..lineTo(offset.dx + -size, offset.dy + -_trih)
      ..lineTo(offset.dx + 0, offset.dy + -_trih)
      ..lineTo(offset.dx + -size / 2, offset.dy + 0);
  }

  get width => size * nx / 2;

  get height => _trih * ny;
}
