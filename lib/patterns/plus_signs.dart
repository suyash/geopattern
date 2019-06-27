import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

class PlusSigns extends Pattern {
  final double size;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;
  final double _midl;
  final double _midh;

  PlusSigns(
      {@required this.size,
      @required this.nx,
      @required this.ny,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == nx * ny),
        _midl = size / 3,
        _midh = 2 * size / 3;

  void paint(Canvas canvas, Offset offset) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = strokeColor;
    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[y * nx + x];
        final dx = y % 2;
        final plus = _createPlus(offset +
            Offset(x * _midh + _midl * (dx - 1), y * _midh - size / 2));
        canvas.drawPath(plus, fillPaint);
        canvas.drawPath(plus, strokePaint);
      }
    }
  }

  Path _createPlus(Offset offset) {
    return Path()
      ..moveTo(offset.dx + _midl, offset.dy + 0)
      ..lineTo(offset.dx + _midh, offset.dy + 0)
      ..lineTo(offset.dx + _midh, offset.dy + _midl)
      ..lineTo(offset.dx + size, offset.dy + _midl)
      ..lineTo(offset.dx + size, offset.dy + _midh)
      ..lineTo(offset.dx + _midh, offset.dy + _midh)
      ..lineTo(offset.dx + _midh, offset.dy + size)
      ..lineTo(offset.dx + _midl, offset.dy + size)
      ..lineTo(offset.dx + _midl, offset.dy + _midh)
      ..lineTo(offset.dx + 0, offset.dy + _midh)
      ..lineTo(offset.dx + 0, offset.dy + _midl)
      ..lineTo(offset.dx + _midl, offset.dy + _midl)
      ..lineTo(offset.dx + _midl, offset.dy + 0);
  }

  get width => size * nx / 3;

  get height => size * ny / 3;
}
