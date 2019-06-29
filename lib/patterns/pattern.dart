import 'dart:ui';

/// base class for all patterns
abstract class Pattern {
  /// paint renders a single instance of the pattern on the passed canvas
  /// at the specified offset.
  void paint(Canvas canvas, Offset offset);

  /// the size of the current pattern
  Size get size;
}
