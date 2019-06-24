import 'package:flutter/widgets.dart';

abstract class Pattern {
  void paint(Canvas canvas, double top, double left);
  double get width;
  double get height;
}
