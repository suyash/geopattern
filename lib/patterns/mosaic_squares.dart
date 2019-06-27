import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

class MosaicSquares extends Pattern {
  final double size;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  MosaicSquares(
      {@required this.size,
      @required this.nx,
      @required this.ny,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == 2 * nx * ny);

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
                Offset(2 * size * x + offset.dx, 2 * size * y + offset.dy),
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
                Offset(2 * size * x + offset.dx, 2 * size * y + offset.dy),
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
                Offset(2 * size * x + offset.dx, 2 * size * y + offset.dy),
                strokePaint,
                fillPaint1,
                fillPaint2);
          } else {
            final fillPaint = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i];
            _drawOuter(
                canvas,
                Offset(2 * size * x + offset.dx, 2 * size * y + offset.dy),
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
      ..moveTo(offset.dx, offset.dy + size)
      ..lineTo(offset.dx + size, offset.dy + 2 * size)
      ..lineTo(offset.dx, offset.dy + 2 * size)
      ..lineTo(offset.dx, offset.dy + size);

    canvas.drawPath(bottomright, strokePaint);
    canvas.drawPath(bottomright, fillPaint);

    final bottomleft = Path()
      ..moveTo(offset.dx + 2 * size, offset.dy + size)
      ..lineTo(offset.dx + 2 * size - size, offset.dy + 2 * size)
      ..lineTo(offset.dx + 2 * size, offset.dy + 2 * size)
      ..lineTo(offset.dx + 2 * size, offset.dy + size);

    canvas.drawPath(bottomleft, strokePaint);
    canvas.drawPath(bottomleft, fillPaint);

    final topleft = Path()
      ..moveTo(offset.dx, offset.dy + size)
      ..lineTo(offset.dx + size, offset.dy + size - size)
      ..lineTo(offset.dx, offset.dy + size - size)
      ..lineTo(offset.dx, offset.dy + size);

    canvas.drawPath(topleft, strokePaint);
    canvas.drawPath(topleft, fillPaint);

    final topright = Path()
      ..moveTo(offset.dx + 2 * size, offset.dy + size)
      ..lineTo(offset.dx + 2 * size - size, offset.dy + size - size)
      ..lineTo(offset.dx + 2 * size, offset.dy + size - size)
      ..lineTo(offset.dx + 2 * size, offset.dy + size);

    canvas.drawPath(topright, strokePaint);
    canvas.drawPath(topright, fillPaint);
  }

  void _drawInner(Canvas canvas, Offset offset, Paint strokePaint,
      Paint fillPaint1, Paint fillPaint2) {
    final topleft = Path()
      ..moveTo(offset.dx + size, offset.dy)
      ..lineTo(offset.dx + size - size, offset.dy + size)
      ..lineTo(offset.dx + size, offset.dy + size)
      ..lineTo(offset.dx + size, offset.dy);

    canvas.drawPath(topleft, strokePaint);
    canvas.drawPath(topleft, fillPaint1);

    final bottomright = Path()
      ..moveTo(offset.dx + size, offset.dy + 2 * size)
      ..lineTo(offset.dx + size + size, offset.dy + 2 * size - size)
      ..lineTo(offset.dx + size, offset.dy + 2 * size - size)
      ..lineTo(offset.dx + size, offset.dy + 2 * size);

    canvas.drawPath(bottomright, strokePaint);
    canvas.drawPath(bottomright, fillPaint1);

    final topright = Path()
      ..moveTo(offset.dx + size, offset.dy)
      ..lineTo(offset.dx + size + size, offset.dy + size)
      ..lineTo(offset.dx + size, offset.dy + size)
      ..lineTo(offset.dx + size, offset.dy);

    canvas.drawPath(topright, strokePaint);
    canvas.drawPath(topright, fillPaint2);

    final bottomleft = Path()
      ..moveTo(offset.dx + size, offset.dy + 2 * size)
      ..lineTo(offset.dx + size - size, offset.dy + 2 * size - size)
      ..lineTo(offset.dx + size, offset.dy + 2 * size - size)
      ..lineTo(offset.dx + size, offset.dy + 2 * size);

    canvas.drawPath(bottomleft, strokePaint);
    canvas.drawPath(bottomleft, fillPaint2);
  }

  get width {
    return size * nx * 2;
  }

  get height {
    return size * ny * 2;
  }
}
