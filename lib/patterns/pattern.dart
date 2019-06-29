import 'dart:ui';

abstract class Pattern {
  void paint(Canvas canvas, Offset offset);
  Size get size;
}
