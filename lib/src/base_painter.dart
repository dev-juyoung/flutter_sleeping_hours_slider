import 'dart:math';

import 'package:flutter/material.dart';

import 'utils.dart';

class BasePainter extends CustomPainter {
  final Color sliderColor;
  final Color sectorColor;
  final int sectorCount;
  final double sectorSize;
  final double sliderStrokeWidth;
  final double sectorStrokeWidth;

  Offset center;
  double radius;

  BasePainter({
    @required this.sliderColor,
    @required this.sectorColor,
    @required this.sectorCount,
    @required this.sectorSize,
    @required this.sliderStrokeWidth,
    @required this.sectorStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = getPaint(color: sliderColor, width: sliderStrokeWidth);

    center = getCenter(size);
    radius = getRadius(size, sliderStrokeWidth);

    canvas.drawCircle(center, radius, paint);

    if (sectorCount != null && sectorCount > 0) {
      _paintSectors(sectorCount, sectorSize, sectorColor, canvas);
      _paintSectors(sectorCount * 5, sectorSize / 2, sectorColor, canvas);
    }
  }

  void _paintSectors(
    int sectors,
    double radiusPadding,
    Color color,
    Canvas canvas,
  ) {
    Paint paint = getPaint(color: sectorColor, width: sectorStrokeWidth);

    final initSectors = getSectionsCoordinatesInCircle(
        center, _calculateSectorRadius(true, radiusPadding), sectors);
    final endSectors = getSectionsCoordinatesInCircle(
        center, _calculateSectorRadius(false, radiusPadding), sectors);

    for (var i = 0; i < initSectors.length; i++) {
      canvas.drawLine(initSectors[i], endSectors[i], paint);
    }
  }

  double _calculateSectorRadius(bool initSector, double radiusPadding) {
    if (initSector) {
      return (radius - radiusPadding) -
          (sliderStrokeWidth / 2 + (sectorSize * 3));
    } else {
      return (radius + radiusPadding) -
          (sliderStrokeWidth / 2 + (sectorSize * 3));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
