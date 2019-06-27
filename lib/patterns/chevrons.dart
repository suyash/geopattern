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

  void paint(Canvas canvas, Offset offset) {
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

        final leftChevron = _createChevronLeft(Offset(
            offset.dx + x * size, offset.dy + (2 * size * y) / 3 - size / 2));
        final rightChevron = _createChevronRight(Offset(
            offset.dx + x * size, offset.dy + (2 * size * y) / 3 - size / 2));

        canvas.drawPath(leftChevron, strokePaint);
        canvas.drawPath(leftChevron, fillPaint);
        canvas.drawPath(rightChevron, strokePaint);
        canvas.drawPath(rightChevron, fillPaint);

        // NOTE: not filling gaps in topmost row for now
      }
    }
  }

  Path _createChevronLeft(Offset offset) {
    final e = (size * 2) / 3;
    return Path()
      ..moveTo(offset.dx, offset.dy)
      ..lineTo(offset.dx + size / 2, offset.dy + size - e)
      ..lineTo(offset.dx + size / 2, offset.dy + size)
      ..lineTo(offset.dx, offset.dy + e)
      ..lineTo(offset.dx, offset.dy);
  }

  Path _createChevronRight(Offset offset) {
    final e = (size * 2) / 3;
    return Path()
      ..moveTo(offset.dx + size / 2, offset.dy + size - e)
      ..lineTo(offset.dx + size, offset.dy)
      ..lineTo(offset.dx + size, offset.dy + e)
      ..lineTo(offset.dx + size / 2, offset.dy + size)
      ..lineTo(offset.dx + size / 2, offset.dy + size - e);
  }

  get width {
    return size * nx;
  }

  get height {
    return ((size * ny * 2) / 3).ceil() * 1.0;
  }
}
