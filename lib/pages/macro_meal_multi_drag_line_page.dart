import 'dart:math';

import 'package:flutter/material.dart';

class MacroMealMultiDragLinePage extends StatelessWidget {
  const MacroMealMultiDragLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: MultiSlider(),
      ),
    );
  }
}

class MultiSlider extends StatefulWidget {
  MultiSlider({Key? key}) : super(key: key);

  @override
  _MultiSliderState createState() => _MultiSliderState();
}

class _MultiSliderState extends State<MultiSlider> {
  late List<double> _thumbXPositions;

  int _currentThumbDragIndex = 0;
  int _divisions = 100;

  List<double> get _steps =>
      List.generate(_divisions + 1, (index) => 100 / _divisions * index);

  @override
  void initState() {
    super.initState();
    _thumbXPositions = [0.5, 0.8];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        _currentThumbDragIndex =
            findClosestThumbIndex(details.localPosition.dx);

        updateThumbPosition(details.localPosition.dx);
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        updateThumbPosition(details.localPosition.dx);
      },
      child: Container(
          width: 600,
          height: 30,
          child: CustomPaint(
              painter: MultiSliderPainter(
                  _thumbXPositions[0], _thumbXPositions[1]))),
    );
  }

  void updateThumbPosition(double dx) {
    if (_currentThumbDragIndex == 0) {
      if (_thumbXPositions[_currentThumbDragIndex] <= _thumbXPositions[1]) {
        setState(() {
          _thumbXPositions[_currentThumbDragIndex] = closestDivision(
              min(dx / 600, _thumbXPositions[1] - 100 / _divisions / 100));
        });
      }
    } else if (_currentThumbDragIndex == _thumbXPositions.length - 1) {
      if (_thumbXPositions[_currentThumbDragIndex] >=
          _thumbXPositions[_currentThumbDragIndex - 1]) {
        setState(() {
          _thumbXPositions[_currentThumbDragIndex] = closestDivision(max(
              dx / 600,
              _thumbXPositions[_currentThumbDragIndex - 1] +
                  100 / _divisions / 100));
        });
      }
    }
  }

  double closestDivision(double x) {
    double closest = -1;
    double closestDistance = double.maxFinite;
    for (int i = 0; i < _steps.length; i++) {
      double distance = (x - _steps[i] / 100).abs();
      if (distance < closestDistance) {
        closest = _steps[i] / 100;
        closestDistance = distance;
      }
    }
    return closest;
  }

  int findClosestThumbIndex(double dx) {
    int closest = -1;
    double closestDistance = double.maxFinite;
    for (int i = 0; i < _thumbXPositions.length; i++) {
      double distance = (dx - _thumbXPositions[i] * 600).abs();
      if (distance < closestDistance) {
        closest = i;
        closestDistance = distance;
      }
    }
    return closest;
  }
}

class MultiSliderPainter extends CustomPainter {
  final double firstThumb;
  final double secondThumb;

  MultiSliderPainter(this.firstThumb, this.secondThumb);

  @override
  void paint(Canvas canvas, Size size) {
    var centerY = size.height / 2;

    var thumbWidth = 40.0;
    var thumbHeight = 30.0;

    var firstThumbRect = Rect.fromCenter(
        center: Offset(size.width * firstThumb, centerY),
        width: thumbWidth,
        height: thumbHeight);

    var secondThumbRect = Rect.fromCenter(
        center: Offset(size.width * secondThumb, centerY),
        width: thumbWidth,
        height: thumbHeight);

    var firstSectionLineBrush = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    var secondSectionLineBrush = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    var thirdSectionLineBrush = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    var thumbFill = Paint()..color = Colors.black;

    canvas.drawLine(Offset(0, centerY),
        Offset(size.width * firstThumb, centerY), firstSectionLineBrush);
    canvas.drawLine(Offset(size.width * firstThumb, centerY),
        Offset(size.width * secondThumb, centerY), secondSectionLineBrush);
    canvas.drawLine(Offset(size.width * secondThumb, centerY),
        Offset(size.width, centerY), thirdSectionLineBrush);

    canvas.drawRRect(
        RRect.fromRectAndRadius(firstThumbRect, Radius.circular(10)),
        thumbFill);
    canvas.drawRRect(
        RRect.fromRectAndRadius(secondThumbRect, Radius.circular(10)),
        thumbFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
