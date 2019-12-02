import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'base_painter.dart';
import 'slider_painter.dart';
import 'custom_pan_gesture_recognizer.dart';
import 'utils.dart';

typedef SelectionChanged<T> = void Function(T a, T b);

class CircularSliderPaint extends StatefulWidget {
  final int divisions;
  final int initValue;
  final int endValue;
  final int sectorCount;
  final double sectorSize;
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

  CircularSliderPaint({
    @required this.divisions,
    @required this.initValue,
    @required this.endValue,
    @required this.sectorCount,
    @required this.sectorSize,
    @required this.child,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.secondaryColor,
    @required this.sectorColor,
    @required this.sliderStrokeWidth,
    @required this.sectorStrokeWidth,
    @required this.initHandlerImage,
    @required this.endHandlerImage,
    @required this.onSelectionChanged,
    @required this.onSelectionEnd,
  });

  @override
  _CircularSliderPaintState createState() => _CircularSliderPaintState();
}

class _CircularSliderPaintState extends State<CircularSliderPaint> {
  SliderPainter _foregroundPainter;
  double _startAngle;
  double _endAngle;
  double _sweepAngle;

  bool _isInitHandlerSelected = false;
  bool _isEndHandlerSelected = false;

  @override
  void initState() {
    super.initState();
    _calculatePaintData();
  }

  @override
  void didUpdateWidget(CircularSliderPaint oldWidget) {
    super.didUpdateWidget(oldWidget);
    _calculatePaintData();
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        CustomPanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<CustomPanGestureRecognizer>(
          () => CustomPanGestureRecognizer(
            onPanDown: _onPanDown,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
          ),
          (CustomPanGestureRecognizer instance) {},
        ),
      },
      child: CustomPaint(
        painter: BasePainter(
          sliderColor: widget.secondaryColor,
          sectorColor: widget.sectorColor,
          sectorCount: widget.sectorCount,
          sectorSize: widget.sectorSize,
          sliderStrokeWidth: widget.sliderStrokeWidth,
          sectorStrokeWidth: widget.sectorStrokeWidth,
        ),
        child: widget.child,
        foregroundPainter: _foregroundPainter,
      ),
    );
  }

  void _calculatePaintData() {
    final initPercent = valueToPercentage(widget.initValue, widget.divisions);
    final endPercent = valueToPercentage(widget.endValue, widget.divisions);
    final sweepAngle = getSweepAngle(initPercent, endPercent);

    _startAngle = percentageToRadians(initPercent);
    _endAngle = percentageToRadians(endPercent);
    _sweepAngle = percentageToRadians(sweepAngle.abs());

    _foregroundPainter = SliderPainter(
      startAngle: _startAngle,
      endAngle: _endAngle,
      sweepAngle: _sweepAngle,
      sliderColor: widget.primaryColor,
      handlerColor: widget.accentColor,
      sliderStrokeWidth: widget.sliderStrokeWidth,
      initHandlerImage: widget.initHandlerImage,
      endHandlerImage: widget.endHandlerImage,
    );
  }

  bool _onPanDown(Offset details) {
    if (_foregroundPainter == null) return false;

    RenderBox renderBox = context.findRenderObject();
    final position = renderBox.globalToLocal(details);
    if (position == null) return false;

    _isInitHandlerSelected = isPointInsideCircle(
      position,
      _foregroundPainter.initHandler,
      widget.sliderStrokeWidth,
    );

    if (!_isInitHandlerSelected) {
      _isEndHandlerSelected = isPointInsideCircle(
        position,
        _foregroundPainter.endHandler,
        widget.sliderStrokeWidth,
      );
    }

    return _isInitHandlerSelected || _isEndHandlerSelected;
  }

  void _onPanUpdate(Offset details) {
    if (!_isInitHandlerSelected && !_isEndHandlerSelected) return;
    if (_foregroundPainter.center == null) return;

    _handlePan(details, false);
  }

  void _onPanEnd(Offset details) {
    _handlePan(details, true);

    _isInitHandlerSelected = false;
    _isEndHandlerSelected = false;
  }

  void _handlePan(Offset details, bool isPanEnd) {
    RenderBox renderBox = context.findRenderObject();
    final position = renderBox.globalToLocal(details);

    final angle = coordinatesToRadians(_foregroundPainter.center, position);
    final percentage = radiansToPercentage(angle);
    final newValue = percentageToValue(percentage, widget.divisions);

    if (_isInitHandlerSelected) {
      widget.onSelectionChanged(newValue, widget.endValue);
      if (isPanEnd) {
        widget.onSelectionEnd(newValue, widget.endValue);
      }
    } else {
      widget.onSelectionChanged(widget.initValue, newValue);
      if (isPanEnd) {
        widget.onSelectionEnd(widget.initValue, newValue);
      }
    }
  }
}
