import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

class Plaid extends Pattern {
  final List<double> horizontalOffsets;
  final List<double> verticalOffsets;
  final List<double> horizontalSizes;
  final List<double> verticalSizes;
  final List<Color> horizontalFillColors;
  final List<Color> verticalFillColors;
  final int _nx;
  final int _ny;

  Plaid(
      {@required this.horizontalOffsets,
      @required this.verticalOffsets,
      @required this.horizontalSizes,
      @required this.verticalSizes,
      @required this.horizontalFillColors,
      @required this.verticalFillColors})
      : _nx = horizontalSizes.length,
        _ny = verticalSizes.length,
        assert(horizontalFillColors.length == horizontalSizes.length),
        assert(verticalFillColors.length == verticalSizes.length),
        assert(horizontalOffsets.length == horizontalSizes.length),
        assert(verticalOffsets.length == verticalSizes.length);

  void paint(Canvas canvas, Offset offset) {
    double left = 0;
    for (var i = 0; i < _nx; i++) {
      left += horizontalOffsets[i];
      final rect = Rect.fromLTWH(
          offset.dx + left, offset.dy, horizontalSizes[i], height);
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = this.horizontalFillColors[i];
      canvas.drawRect(rect, fillPaint);
      left += horizontalSizes[i];
    }

    double top = 0;
    for (var i = 0; i < _ny; i++) {
      top += verticalOffsets[i];
      final rect = Rect.fromLTWH(
          offset.dx, offset.dy + top, width, verticalSizes[i]);
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = this.verticalFillColors[i];
      canvas.drawRect(rect, fillPaint);
      top += verticalSizes[i];
    }
  }

  get width =>
      horizontalSizes.reduce((a, b) => a + b) +
      horizontalOffsets.reduce((a, b) => a + b);

  get height =>
      verticalSizes.reduce((a, b) => a + b) +
      verticalOffsets.reduce((a, b) => a + b);
}
