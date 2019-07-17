import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/overlapping_circles.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.yellow,
            expandedHeight: 256,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("AppBar"),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AppBarBackground(),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            Card(child: Container(height: 200)),
            Card(child: Container(height: 200)),
            Card(child: Container(height: 200)),
            Card(child: Container(height: 200)),
            Card(child: Container(height: 200)),
            Card(child: Container(height: 200)),
          ]))
        ],
      ),
    ));
  }
}

class AppBarBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final gen = Random();
      final pattern = OverlappingCircles(
          radius: 60,
          nx: 6,
          ny: 6,
          fillColors: List.generate(
              36,
              (int i) => Color.fromARGB(
                  10 + (gen.nextDouble() * 100).round(),
                  50 + gen.nextInt(2) * 150,
                  50 + gen.nextInt(2) * 150,
                  50 + gen.nextInt(2) * 150)));
      return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: FullPainter(pattern: pattern, background: Colors.yellow));
    });
  }
}
