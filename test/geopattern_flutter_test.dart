import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:geopattern_flutter/patterns/chevrons.dart';
import 'package:geopattern_flutter/patterns/concentric_circles.dart';
import 'package:geopattern_flutter/patterns/diamonds.dart';
import 'package:geopattern_flutter/patterns/hexagons.dart';
import 'package:geopattern_flutter/patterns/mosaic_squares.dart';
import 'package:geopattern_flutter/patterns/nested_squares.dart';
import 'package:geopattern_flutter/patterns/octagons.dart';
import 'package:geopattern_flutter/patterns/overlapping_circles.dart';
import 'package:geopattern_flutter/patterns/overlapping_rings.dart';
import 'package:geopattern_flutter/patterns/plaid.dart';
import 'package:geopattern_flutter/patterns/plus_signs.dart';
import 'package:geopattern_flutter/patterns/sine_waves.dart';
import 'package:geopattern_flutter/patterns/squares.dart';
import 'package:geopattern_flutter/patterns/triangles.dart';

void main() {
  test('chevrons', () {
    final gen = Random();
    final pattern = Chevrons(
        side: 30,
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
    expect(pattern.size.width, 180);
    expect(pattern.size.height, 120);
  });
  test('concentric_circles', () {
    final gen = Random();
    final pattern = ConcentricCircles(
        radius: 30,
        nx: 6,
        ny: 6,
        strokeColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)),
        fillColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)),
        strokeWidth: 10);
    expect(pattern.size.width, 240);
    expect(pattern.size.height, 240);
  });
  test('diamonds', () {
    final gen = Random();
    final pattern = Diamonds(
        w: 30,
        h: 30,
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
    expect(pattern.size.width, 180);
    expect(pattern.size.height, 90);
  });
  test('hexagons', () {
    final gen = Random();
    final pattern = Hexagons(
        side: 30,
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
    expect(pattern.size.width, 270);
    expect(pattern.size.height, 311.76914536239786);
  });
  test('mosaic_squares', () {
    final gen = Random();
    final pattern = MosaicSquares(
        side: 30,
        nx: 4,
        ny: 4,
        fillColors: List.generate(
            32,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)),
        strokeColor: Color.fromARGB(50, 50, 50, 50));
    expect(pattern.size.width, 240);
    expect(pattern.size.height, 240);
  });
  test('nested_squares', () {
    final gen = Random();
    final pattern = NestedSquares(
        side: 30,
        outerside: 90,
        nx: 6,
        ny: 6,
        strokeColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)));
    expect(pattern.size.width, 900);
    expect(pattern.size.height, 900);
  });
  test('octagons', () {
    final gen = Random();
    final pattern = Octagons(
        side: 30,
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
    expect(pattern.size.width, 180);
    expect(pattern.size.height, 180);
  });
  test('overlapping_circles', () {
    final gen = Random();
    final pattern = OverlappingCircles(
        radius: 30,
        nx: 6,
        ny: 6,
        fillColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)));
    expect(pattern.size.width, 180);
    expect(pattern.size.height, 180);
  });
  test('overlapping_rings', () {
    final gen = Random();
    final pattern = OverlappingRings(
        radius: 30,
        strokeWidth: 10,
        nx: 6,
        ny: 6,
        strokeColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)));
    expect(pattern.size.width, 180);
    expect(pattern.size.height, 180);
  });
  test('plaid', () {
    final gen = Random();
    final pattern = Plaid(
        horizontalOffsets: List.generate(36, (int i) => i * 5.0),
        verticalOffsets: List.generate(36, (int i) => i * 5.0),
        horizontalSizes: List.generate(36, (int i) => i * 5.0),
        verticalSizes: List.generate(36, (int i) => i * 5.0),
        horizontalFillColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)),
        verticalFillColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)));
    expect(pattern.size.width, 6300);
    expect(pattern.size.height, 6300);
  });
  test('plus_signs', () {
    final gen = Random();
    final pattern = PlusSigns(
        side: 30,
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
    expect(pattern.size.width, 60);
    expect(pattern.size.height, 60);
  });
  test('sine_waves', () {
    final gen = Random();
    final pattern = SineWaves(
        amplitude: 200,
        period: 70,
        strokeColors: List.generate(
            36,
            (int i) => Color.fromARGB(
                10 + (gen.nextDouble() * 100).round(),
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150,
                50 + gen.nextInt(1) * 150)),
        strokeOffsets: List.generate(36, (int i) => i * 5.0),
        strokeWidth: 2);
    expect(pattern.size.width, 70);
    expect(pattern.size.height, 200);
  });
  test('squares', () {
    final gen = Random();
    final pattern = Squares(
        side: 30,
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
    expect(pattern.size.width, 180);
    expect(pattern.size.height, 180);
  });
  test('triangles', () {
    final gen = Random();
    final pattern = Triangles(
        side: 30,
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
    expect(pattern.size.width, 90);
    expect(pattern.size.height, 155.88457268119893);
  });
}
