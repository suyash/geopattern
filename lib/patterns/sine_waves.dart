import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'pattern.dart';

/// Draws Sine waves using a cubic bezier curve approximation
/// The approximation is different from the original library, this
/// draws only a single period using 2 cubic paths.
///
/// https://github.com/suyash/geopattern_flutter/blob/master/examples/images/sine_waves.png
class SineWaves extends Pattern {
  final double amplitude;
  final double period;
  final List<double> strokeOffsets;
  final double strokeWidth;
  final List<Color> strokeColors;
  final double _xoff;

  SineWaves(
      {required this.period,
      required this.amplitude,
      required this.strokeOffsets,
      required this.strokeWidth,
      required this.strokeColors})
      : _xoff = (period / 4) * .7,
        assert(strokeOffsets.length == strokeColors.length);

  SineWaves.fromHash(String hash)
      : assert(hash.length == 40),
        amplitude = int.parse(hash[0], radix: 16) / 16.0 * 50 + 20,
        period = int.parse(hash[1], radix: 16) / 16.0 * 50 + 100,
        strokeOffsets = hash.split("").map((String c) {
          final v = int.parse(c, radix: 16);
          final amplitude = int.parse(hash[0], radix: 16) / 16.0 * 300 + 100;
          return v / 16 * amplitude - amplitude / 2;
        }).toList(),
        strokeWidth = int.parse(hash[2], radix: 16) * 1.0,
        strokeColors = hash.split("").map((String c) {
          final v = int.parse(c, radix: 16);
          final g = 50 + (v % 1) * 150;
          return Color.fromARGB(((v / 16.0) * 100 + 50).round(), g, g, g);
        }).toList(),
        _xoff = ((int.parse(hash[1], radix: 16) / 16.0 * 70 + 30) / 4) * .7;

  void paint(Canvas canvas, Offset offset) {
    for (var i = 0; i < strokeOffsets.length; i++) {
      final strokePaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = strokeColors[i]
        ..strokeWidth = strokeWidth;
      final wave = _createWave(offset + Offset(0, strokeOffsets[i]));
      canvas.drawPath(wave, strokePaint);
    }
  }

  Path _createWave(Offset offset) {
    return Path()
      ..moveTo(offset.dx + 0, offset.dy + amplitude)
      ..cubicTo(
          offset.dx + _xoff,
          offset.dy + 0,
          offset.dx + period / 2 - _xoff,
          offset.dy + 0,
          offset.dx + period / 2,
          offset.dy + amplitude)
      ..cubicTo(
          offset.dx + period / 2 + _xoff,
          offset.dy + amplitude * 2,
          offset.dx + period - _xoff,
          offset.dy + amplitude * 2,
          offset.dx + period,
          offset.dy + amplitude);
  }

  Size get size => Size(period, amplitude);
}
