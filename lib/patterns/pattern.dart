import 'dart:ui';

abstract class Pattern {
  void paint(Canvas canvas, Offset offset);
  double get width;
  double get height;
}
