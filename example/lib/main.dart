import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sleeping_hours_slider/flutter_sleeping_hours_slider.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  int _initValue;
  int _endValue;
  ui.Image _initHandlerImage;
  ui.Image _endHandlerImage;

  Future<ui.Image> _loadAssetImage(String assets) async {
    final Completer<ui.Image> completer = Completer();

    final ByteData data = await rootBundle.load(assets);
    ui.decodeImageFromList(Uint8List.view(data.buffer), (image) {
      return completer.complete(image);
    });

    return completer.future;
  }

  String _formatTime(int time) {
    if (time == 0 || time == null) {
      return '00:00';
    }

    final hours = time ~/ 12;
    final minutes = (time % 12) * 5;
    return '$hours:$minutes';
  }

  String _formatIntervalTime(int init, int end) {
    final sleepTime = end > init ? end - init : 288 - init + end;
    final hours = sleepTime ~/ 12;
    final minutes = (sleepTime % 12) * 5;
    return '${hours}h ${minutes}m';
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _initValue = 264;
      _endValue = 102;
    });

    _loadAssetImage('assets/icon_night.png').then((image) {
      setState(() {
        _initHandlerImage = image;
      });
    });

    _loadAssetImage('assets/icon_day.png').then((image) {
      setState(() {
        _endHandlerImage = image;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SleepingHoursSlider(
            primaryColor: Color.fromRGBO(253, 184, 171, 1.0),
            accentColor: Color.fromRGBO(253, 184, 171, 1.0),
            secondaryColor: Color.fromRGBO(0, 0, 0, 0.1),
            sectorColor: Color.fromRGBO(255, 241, 232, 1.0),
            divisions: 288,
            initValue: _initValue,
            endValue: _endValue,
            sectorCount: 24,
            initHandlerImage: _initHandlerImage,
            endHandlerImage: _endHandlerImage,
            onSelectionChanged: (newInit, newEnd) {
              setState(() {
                _initValue = newInit;
                _endValue = newEnd;
              });
            },
            child: Center(
              child: Text(_formatIntervalTime(_initValue, _endValue)),
            ),
          ),
        ),
      ),
    );
  }
}
