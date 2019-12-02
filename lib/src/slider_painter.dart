import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'utils.dart';

class SliderPainter extends CustomPainter {
  final double startAngle;
  final double endAngle;
  final double sweepAngle;
  final Color sliderColor;
  final Color handlerColor;
  final double sliderStrokeWidth;
  final ui.Image initHandlerImage;
  final ui.Image endHandlerImage;

  Offset center;
  double radius;

  Offset initHandler;
  Offset endHandler;

  SliderPainter({
    @required this.startAngle,
    @required this.endAngle,
    @required this.sweepAngle,
    @required this.sliderColor,
    @required this.handlerColor,
    @required this.sliderStrokeWidth,
    @required this.initHandlerImage,
    @required this.endHandlerImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint slider = getPaint(color: sliderColor, width: sliderStrokeWidth);

    center = getCenter(size);
    radius = getRadius(size, sliderStrokeWidth);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + startAngle,
      sweepAngle,
      false,
      slider,
    );

    Paint handler = getPaint(
      color: handlerColor,
      width: sliderStrokeWidth,
      style: PaintingStyle.fill,
    );

    initHandler = radiansToCoordinates(center, -pi / 2 + startAngle, radius);
    endHandler = radiansToCoordinates(center, -pi / 2 + endAngle, radius);

    if (initHandlerImage != null && endHandlerImage != null) {
      final newInitHandlerOffset = Offset(
        initHandler.dx - (initHandlerImage.width / 2),
        initHandler.dy - (initHandlerImage.height / 2),
      );

      final newEndHandlerOffset = Offset(
        endHandler.dx - (endHandlerImage.width / 2),
        endHandler.dy - (endHandlerImage.height / 2),
      );

      canvas.drawImage(initHandlerImage, newInitHandlerOffset, Paint());
      canvas.drawImage(endHandlerImage, newEndHandlerOffset, Paint());
    } else {
      canvas.drawCircle(initHandler, sliderStrokeWidth / 2, handler);
      canvas.drawCircle(endHandler, sliderStrokeWidth / 2, handler);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
