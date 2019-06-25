import 'package:flutter/widgets.dart';

import 'pattern.dart';

class Chevrons extends Pattern {
  final double size;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  Chevrons(
      {@required this.size,
      @required this.nx,
      @required this.ny,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == nx * ny);

  void paint(Canvas canvas, double top, double left) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.strokeColor
      ..strokeWidth = 1;

    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];

        final leftChevron = _createChevronLeft(
            top + (2 * size * y) / 3 - size / 2, left + x * size);
        final rightChevron = _createChevronRight(
            top + (2 * size * y) / 3 - size / 2, left + x * size);

        canvas.drawPath(leftChevron, strokePaint);
        canvas.drawPath(leftChevron, fillPaint);
        canvas.drawPath(rightChevron, strokePaint);
        canvas.drawPath(rightChevron, fillPaint);

        // NOTE: not filling gaps in topmost row for now
      }
    }
  }

  Path _createChevronLeft(double top, double left) {
    final e = (size * 2) / 3;
    return Path()
      ..moveTo(left, top)
      ..lineTo(left + size / 2, top + size - e)
      ..lineTo(left + size / 2, top + size)
      ..lineTo(left, top + e)
      ..lineTo(left, top);
  }

  Path _createChevronRight(double top, double left) {
    final e = (size * 2) / 3;
    return Path()
      ..moveTo(left + size / 2, top + size - e)
      ..lineTo(left + size, top)
      ..lineTo(left + size, top + e)
      ..lineTo(left + size / 2, top + size)
      ..lineTo(left + size / 2, top + size - e);
  }

  get width {
    return size * nx;
  }

  get height {
    return ((size * ny * 2) / 3).ceil() * 1.0;
  }
}
