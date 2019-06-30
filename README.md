# geopattern_flutter

> Flutter Port of [jasonlong/geo_pattern](https://github.com/jasonlong/geo_pattern)

Geometric Patterns for Flutter using `CustomPainter`s.

<div>
<img src="https://github.com/suyash/geopattern/blob/master/example/images/squares.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/diamonds.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/hexagons.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/concentric_circles.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/overlapping_circles.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/overlapping_rings.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/nested_squares.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/mosaic_squares.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/chevrons.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/octagons.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/plaid.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/plus_signs.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/triangles.png?raw=true" height="450" />
<img src="https://github.com/suyash/geopattern/blob/master/example/images/sine_waves.png?raw=true" height="450" />
</div>

## Simple Example

```dart
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/mosaic_squares.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hash = sha1.convert(utf8.encode("flutter")).toString();
    return LayoutBuilder(builder: (context, constraints) {
      final pattern = MosaicSquares.fromHash(hash);
      return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: FullPainter(pattern: pattern, background: Colors.blueGrey));
    });
  }
}
```

creates

<img src="https://github.com/suyash/geopattern/blob/master/example/images/simple.png?raw=true" height="480">

Patterns are fully customizable, for example a pattern created as

```dart
final pattern = ConcentricCircles(
  radius: 40,
  strokeWidth: 8,
  nx: 6,
  ny: 6,
  strokeColors: List.generate(
      36,
      (int i) => Color.fromARGB(
          10 + (gen.nextDouble() * 100).round(),
          50 + gen.nextInt(2) * 150,
          50 + gen.nextInt(2) * 150,
          50 + gen.nextInt(2) * 150)),
  fillColors: List.generate(
      36,
      (int i) => Color.fromARGB(
          10 + (gen.nextDouble() * 100).round(),
          50 + gen.nextInt(2) * 150,
          50 + gen.nextInt(2) * 150,
          50 + gen.nextInt(2) * 150)));
```

renders

<img src="https://github.com/suyash/geopattern/blob/master/example/images/overlapping_circles.png?raw=true" height="480">

Each pattern has an associated `size`. The `FillPainter` class implements `CustomPainter` such that the pattern is repetitively painted across the entire width and height of the canvas. However, each `Pattern` has a `paint(Canvas, Offset)` method that can be used to paint on its own.

There is an example for using a pattern as a background for `SliverAppBar` in `example/appbar.dart`

[Demo](https://i.imgur.com/iPj0sMo.mp4)

### TODO

- Tesselation
- Xes
