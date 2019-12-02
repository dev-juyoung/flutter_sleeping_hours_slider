import 'dart:math';

import 'package:flutter/material.dart';

Paint getPaint({
  @required Color color,
  @required double width,
  StrokeCap strokeCap,
  PaintingStyle style,
}) {
  return Paint()
    ..color = color
    ..strokeCap = strokeCap ?? StrokeCap.round
    ..style = style ?? PaintingStyle.stroke
    ..strokeWidth = width;
}

Offset getCenter(Size size) => Offset(size.width / 2, size.height / 2);

double getRadius(Size size, double width) =>
    min(size.width / 2, size.height / 2) - width;

double valueToPercentage(int time, int intervals) => (time / intervals) * 100;

int percentageToValue(double percentage, int intervals) =>
    ((percentage * intervals) / 100).round();

double getSweepAngle(double init, double end) {
  if (end > init) {
    return end - init;
  }

  return (100 - init + end).abs();
}

double percentageToRadians(double percentage) => ((2 * pi * percentage) / 100);

double radiansToPercentage(double radians) {
  final normalized = radians < 0 ? -radians : 2 * pi - radians;
  final percentage = ((100 * normalized) / (2 * pi));
  return (percentage + 25) % 100;
}

double coordinatesToRadians(Offset center, Offset coordinates) {
  final a = coordinates.dx - center.dx;
  final b = center.dy - coordinates.dy;
  return atan2(b, a);
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * cos(radians);
  var dy = center.dy + radius * sin(radians);
  return Offset(dx, dy);
}

bool isPointInsideCircle(Offset point, Offset center, double radius) {
  // final radius = rradius * 1.2;
  return point.dx < (center.dx + radius) &&
      point.dx > (center.dx - radius) &&
      point.dy < (center.dy + radius) &&
      point.dy > (center.dy - radius);
}

List<Offset> getSectionsCoordinatesInCircle(
  Offset center,
  double radius,
  int sectorCount,
) {
  final intervalAngle = (pi * 2) / sectorCount;
  return List<int>.generate(sectorCount, (index) => index).map((i) {
    final radians = (pi / 2) + (intervalAngle * i);
    return radiansToCoordinates(center, radians, radius);
  }).toList();
}
