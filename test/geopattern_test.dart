import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:geopattern/patterns/squares.dart';

void main() {
  test('squares', () {
    final gen = Random();
    final pattern = Squares(
        size: 30,
        nx: 6,
        ny: 6,
        fillColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)),
        strokeColor: Color.fromARGB(50, 50, 50, 50));
    expect(pattern.width, 180);
    expect(pattern.height, 180);
  });
}
