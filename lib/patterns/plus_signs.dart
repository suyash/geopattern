import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

class PlusSigns extends Pattern {
  final double side;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;
  final double _midl;
  final double _midh;

  PlusSigns(
      {@required this.side,
      @required this.nx,
      @required this.ny,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == nx * ny),
        _midl = side / 3,
        _midh = 2 * side / 3;

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
            Offset(x * _midh + _midl * (dx - 1), y * _midh - side / 2));
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
      ..lineTo(offset.dx + side, offset.dy + _midl)
      ..lineTo(offset.dx + side, offset.dy + _midh)
      ..lineTo(offset.dx + _midh, offset.dy + _midh)
      ..lineTo(offset.dx + _midh, offset.dy + side)
      ..lineTo(offset.dx + _midl, offset.dy + side)
      ..lineTo(offset.dx + _midl, offset.dy + _midh)
      ..lineTo(offset.dx + 0, offset.dy + _midh)
      ..lineTo(offset.dx + 0, offset.dy + _midl)
      ..lineTo(offset.dx + _midl, offset.dy + _midl)
      ..lineTo(offset.dx + _midl, offset.dy + 0);
  }

  get size => Size(side * nx / 3, side * ny / 3);
}
