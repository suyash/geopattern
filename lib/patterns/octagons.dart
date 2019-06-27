import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

/// https://github.com/jasonlong/geo_pattern/blob/master/lib/geo_pattern/structure_generators/octagons_generator.rb
class Octagons extends Pattern {
  final double size;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  Octagons(
      {@required this.size,
      @required this.nx,
      @required this.ny,
      @required this.fillColors,
      @required this.strokeColor})
      : assert(fillColors.length == nx * ny);

  void paint(Canvas canvas, Offset offset) {
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.strokeColor;

    for (var y = 0; y < ny; y++) {
      for (var x = 0; x < nx; x++) {
        final i = y * nx + x;

        final fillPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = this.fillColors[i];

        final oct =
            _createOctagon(Offset(offset.dx + x * size, offset.dy + y * size));
        canvas.drawPath(oct, fillPaint);
        canvas.drawPath(oct, strokePaint);
      }
    }
  }

  Path _createOctagon(Offset offset) {
    return Path()
      ..moveTo(offset.dx + size / 3, offset.dy + 0)
      ..lineTo(offset.dx + 2 * size / 3, offset.dy + 0)
      ..lineTo(offset.dx + size, offset.dy + size / 3)
      ..lineTo(offset.dx + size, offset.dy + 2 * size / 3)
      ..lineTo(offset.dx + 2 * size / 3, offset.dy + size)
      ..lineTo(offset.dx + size / 3, offset.dy + size)
      ..lineTo(offset.dx + 0, offset.dy + 2 * size / 3)
      ..lineTo(offset.dx + 0, offset.dy + size / 3)
      ..lineTo(offset.dx + size / 3, offset.dy + 0);
  }

  get width {
    return size * nx;
  }

  get height {
    return size * ny;
  }
}
