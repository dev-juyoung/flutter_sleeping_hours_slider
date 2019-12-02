import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'circular_slider_paint.dart';

class SleepingHoursSlider extends StatefulWidget {
  final int divisions;
  final int initValue;
  final int endValue;
  final int sectorCount;
  final double sectorSize;
  final double width;
  final double height;
  final Widget child;
  final Color primaryColor;
  final Color accentColor;
  final Color secondaryColor;
  final Color sectorColor;
  final double sliderStrokeWidth;
  final double sectorStrokeWidth;
  final ui.Image initHandlerImage;
  final ui.Image endHandlerImage;
  final SelectionChanged<int> onSelectionChanged;
  final SelectionChanged<int> onSelectionEnd;

  SleepingHoursSlider({
    @required this.divisions,
    @required this.initValue,
    @required this.endValue,
    this.sectorCount,
    this.sectorSize,
    this.width,
    this.height,
    this.child,
    this.primaryColor,
    this.accentColor,
    this.secondaryColor,
    this.sectorColor,
    this.sliderStrokeWidth,
    this.sectorStrokeWidth,
    this.initHandlerImage,
    this.endHandlerImage,
    this.onSelectionChanged,
    this.onSelectionEnd,
  })  : assert(divisions != null, 'divisions properties is cannot be null'),
        assert(initValue != null, 'initValue properties is cannot be null'),
        assert(endValue != null, 'endValue properties is cannot be null');

  @override
  _SleepingHoursSliderState createState() => _SleepingHoursSliderState();
}

class _SleepingHoursSliderState extends State<SleepingHoursSlider> {
  int _initValue;
  int _endValue;

  @override
  void initState() {
    super.initState();
    setState(() {
      _initValue = widget.initValue;
      _endValue = widget.endValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 279,
      height: widget.height ?? 279,
      child: CircularSliderPaint(
        divisions: widget.divisions,
        initValue: _initValue,
        endValue: _endValue,
        child: widget.child,
        sectorCount: widget.sectorCount,
        sectorSize: widget.sectorSize ?? 4.0,
        primaryColor: widget.primaryColor ?? Color.fromRGBO(255, 255, 255, 1.0),
        accentColor: widget.accentColor ?? Colors.blue,
        secondaryColor:
            widget.secondaryColor ?? Color.fromRGBO(255, 255, 255, 0.2),
        sectorColor: widget.sectorColor ?? Color.fromRGBO(255, 255, 255, 0.2),
        sliderStrokeWidth: widget.sliderStrokeWidth ?? 28.0,
        sectorStrokeWidth: widget.sectorStrokeWidth ?? 1.0,
        initHandlerImage: widget.initHandlerImage,
        endHandlerImage: widget.endHandlerImage,
        onSelectionChanged: (newInit, newEnd) {
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged(newInit, newEnd);
          }

          setState(() {
            _initValue = newInit;
            _endValue = newEnd;
          });
        },
        onSelectionEnd: (newInit, newEnd) {
          if (widget.onSelectionEnd != null) {
            widget.onSelectionEnd(newInit, newEnd);
          }
        },
      ),
    );
  }
}
