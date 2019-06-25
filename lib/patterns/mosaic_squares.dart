import 'package:flutter/widgets.dart';

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

  void paint(Canvas canvas, double top, double left) {
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
            _drawOuter(canvas, 2 * size * y + top, 2 * size * x + left,
                strokePaint, fillPaint);
          } else {
            final fillPaint1 = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i];
            final fillPaint2 = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i + nx * ny];
            _drawInner(canvas, 2 * size * y + top, 2 * size * x + left,
                strokePaint, fillPaint1, fillPaint2);
          }
        } else {
          if (y % 2 == 1) {
            final fillPaint1 = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i];
            final fillPaint2 = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i + nx * ny];
            _drawInner(canvas, 2 * size * y + top, 2 * size * x + left,
                strokePaint, fillPaint1, fillPaint2);
          } else {
            final fillPaint = Paint()
              ..style = PaintingStyle.fill
              ..color = this.fillColors[i];
            _drawOuter(canvas, 2 * size * y + top, 2 * size * x + left,
                strokePaint, fillPaint);
          }
        }
      }
    }
  }

  void _drawOuter(Canvas canvas, double top, double left, Paint strokePaint,
      Paint fillPaint) {
    final bottomright = Path()
      ..moveTo(left, top + size)
      ..lineTo(left + size, top + 2 * size)
      ..lineTo(left, top + 2 * size)
      ..lineTo(left, top + size);

    canvas.drawPath(bottomright, strokePaint);
    canvas.drawPath(bottomright, fillPaint);

    final bottomleft = Path()
      ..moveTo(left + 2 * size, top + size)
      ..lineTo(left + 2 * size - size, top + 2 * size)
      ..lineTo(left + 2 * size, top + 2 * size)
      ..lineTo(left + 2 * size, top + size);

    canvas.drawPath(bottomleft, strokePaint);
    canvas.drawPath(bottomleft, fillPaint);

    final topleft = Path()
      ..moveTo(left, top + size)
      ..lineTo(left + size, top + size - size)
      ..lineTo(left, top + size - size)
      ..lineTo(left, top + size);

    canvas.drawPath(topleft, strokePaint);
    canvas.drawPath(topleft, fillPaint);

    final topright = Path()
      ..moveTo(left + 2 * size, top + size)
      ..lineTo(left + 2 * size - size, top + size - size)
      ..lineTo(left + 2 * size, top + size - size)
      ..lineTo(left + 2 * size, top + size);

    canvas.drawPath(topright, strokePaint);
    canvas.drawPath(topright, fillPaint);
  }

  void _drawInner(Canvas canvas, double top, double left, Paint strokePaint,
      Paint fillPaint1, Paint fillPaint2) {
    final topleft = Path()
      ..moveTo(left + size, top)
      ..lineTo(left + size - size, top + size)
      ..lineTo(left + size, top + size)
      ..lineTo(left + size, top);

    canvas.drawPath(topleft, strokePaint);
    canvas.drawPath(topleft, fillPaint1);

    final bottomright = Path()
      ..moveTo(left + size, top + 2 * size)
      ..lineTo(left + size + size, top + 2 * size - size)
      ..lineTo(left + size, top + 2 * size - size)
      ..lineTo(left + size, top + 2 * size);

    canvas.drawPath(bottomright, strokePaint);
    canvas.drawPath(bottomright, fillPaint1);

    final topright = Path()
      ..moveTo(left + size, top)
      ..lineTo(left + size + size, top + size)
      ..lineTo(left + size, top + size)
      ..lineTo(left + size, top);

    canvas.drawPath(topright, strokePaint);
    canvas.drawPath(topright, fillPaint2);

    final bottomleft = Path()
      ..moveTo(left + size, top + 2 * size)
      ..lineTo(left + size - size, top + 2 * size - size)
      ..lineTo(left + size, top + 2 * size - size)
      ..lineTo(left + size, top + 2 * size);

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
