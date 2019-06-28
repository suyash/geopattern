import 'dart:ui';

import 'package:meta/meta.dart';

import 'pattern.dart';

// Draws Sine waves using a cubic bezier curve approximation
// The approximation is different from the original library, this
// draws only a single period using 2 cubic paths.
class SineWaves extends Pattern {
  final double amplitude;
  final double period;
  final List<double> strokeOffsets;
  final double strokeWidth;
  final List<Color> strokeColors;
  final double _xoff;

  SineWaves(
      {@required this.period,
      @required this.amplitude,
      @required this.strokeOffsets,
      @required this.strokeWidth,
      @required this.strokeColors})
      : _xoff = (period / 4) * .7,
        assert(strokeOffsets.length == strokeColors.length);

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

  get width => period;

  get height => amplitude;
}
