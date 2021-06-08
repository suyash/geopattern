import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/plaid.png
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
      {required this.horizontalOffsets,
      required this.verticalOffsets,
      required this.horizontalSizes,
      required this.verticalSizes,
      required this.horizontalFillColors,
      required this.verticalFillColors})
      : _nx = horizontalSizes.length,
        _ny = verticalSizes.length,
        assert(horizontalFillColors.length == horizontalSizes.length),
        assert(verticalFillColors.length == verticalSizes.length),
        assert(horizontalOffsets.length == horizontalSizes.length),
        assert(verticalOffsets.length == verticalSizes.length);

  Plaid.fromHash(String hash)
      : assert(hash.length == 40),
        horizontalOffsets = hash
            .substring(0, 20)
            .split("")
            .map((String a) => int.parse(a, radix: 16) + 5.0)
            .toList(),
        verticalOffsets = hash
            .substring(0, 20)
            .split("")
            .map((String a) => int.parse(a, radix: 16) + 5.0)
            .toList(),
        horizontalSizes = hash
            .substring(20)
            .split("")
            .map((String a) => int.parse(a, radix: 16) + 5.0)
            .toList(),
        verticalSizes = hash
            .substring(20)
            .split("")
            .map((String a) => int.parse(a, radix: 16) + 5.0)
            .toList(),
        horizontalFillColors = hash
            .substring(0, 20)
            .split("")
            .map((String a) => Color.fromARGB(
                (50 + (int.parse(a, radix: 16) / 16) * 150).round(),
                50 + (int.parse(a, radix: 16) % 2) * 150,
                50 + (int.parse(a, radix: 16) % 2) * 150,
                50 + (int.parse(a, radix: 16) % 2) * 150))
            .toList(),
        verticalFillColors = hash
            .substring(20)
            .split("")
            .map((String a) => Color.fromARGB(
                (50 + (int.parse(a, radix: 16) / 16) * 150).round(),
                50 + (int.parse(a, radix: 16) % 2) * 150,
                50 + (int.parse(a, radix: 16) % 2) * 150,
                50 + (int.parse(a, radix: 16) % 2) * 150))
            .toList(),
        _nx = 20,
        _ny = 20;

  void paint(Canvas canvas, Offset offset) {
    double left = 0;
    for (var i = 0; i < _nx; i++) {
      left += horizontalOffsets[i];
      final rect = Rect.fromLTWH(
          offset.dx + left, offset.dy, horizontalSizes[i], size.height);
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
          offset.dx, offset.dy + top, size.width, verticalSizes[i]);
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = this.verticalFillColors[i];
      canvas.drawRect(rect, fillPaint);
      top += verticalSizes[i];
    }
  }

  Size get size => Size(
      horizontalSizes.reduce((a, b) => a + b) +
          horizontalOffsets.reduce((a, b) => a + b),
      verticalSizes.reduce((a, b) => a + b) +
          verticalOffsets.reduce((a, b) => a + b));
}
