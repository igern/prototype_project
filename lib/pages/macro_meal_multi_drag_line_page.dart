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
  late List<SliderSection> _sliderSections;

  int _currentThumbDragIndex = 0;
  int _divisions = 100;

  List<double> get _steps =>
      List.generate(_divisions + 1, (index) => 100 / _divisions * index);

  List<SliderSectionData> get _sliderSectionDataList {
    List<SliderSectionData> sliderSectionDataList = [];
    for (int i = 0; i < _sliderSections.length; i++) {
      late double percent;
      if (i == 0) {
        percent = _thumbXPositions[0];
      } else if (i == _sliderSections.length - 1) {
        percent = 1 - _thumbXPositions[i - 1];
      } else {
        percent = _thumbXPositions[i] - _thumbXPositions[i - 1];
      }
      sliderSectionDataList.add(SliderSectionData(
          _sliderSections[i].color, _sliderSections[i].label, percent));
    }
    return sliderSectionDataList;
  }

  @override
  void initState() {
    super.initState();
    _thumbXPositions = [0.3, 0.6, 0.9];
    _sliderSections = [
      SliderSection(Colors.red, 'Protein'),
      SliderSection(Colors.green, 'Carbohydrates'),
      SliderSection(Colors.blue, 'Fat'),
      SliderSection(Colors.purple, 'Fibers'),
    ];
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
          height: 60,
          child: CustomPaint(
              painter: MultiSliderPainter(
                  _thumbXPositions, _sliderSectionDataList))),
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
    } else {
      if (_thumbXPositions[_currentThumbDragIndex] <=
              _thumbXPositions[_currentThumbDragIndex + 1] &&
          _thumbXPositions[_currentThumbDragIndex] >=
              _thumbXPositions[_currentThumbDragIndex - 1]) {
        setState(() {
          _thumbXPositions[_currentThumbDragIndex] = closestDivision(min(
              max(
                  dx / 600,
                  _thumbXPositions[_currentThumbDragIndex - 1] +
                      100 / _divisions / 100),
              _thumbXPositions[_currentThumbDragIndex + 1] -
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

class SliderSection {
  final Color color;
  final String label;

  SliderSection(this.color, this.label);
}

class MultiSliderPainter extends CustomPainter {
  final List<double> thumbs;
  final List<SliderSectionData> sections;

  MultiSliderPainter(this.thumbs, this.sections)
      : assert(thumbs.length > 0),
        assert(sections.length == thumbs.length + 1);

  @override
  void paint(Canvas canvas, Size size) {
    var thumbWidth = 40.0;
    var thumbHeight = 30.0;
    var centerSliderY = size.height - thumbHeight / 2;

    for (int i = 0; i < sections.length; i++) {
      SliderSectionData section = sections[i];

      var sectionLineBrush = Paint()
        ..color = section.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20;

      var sectionTextSpan = TextSpan(
          text:
              '${section.label} ${(section.percent * 100).toStringAsFixed(0)}%',
          style: TextStyle(color: Colors.black));

      var sectionTextPainter = TextPainter(
          text: sectionTextSpan, maxLines: 1, textDirection: TextDirection.ltr);
      if (i == 0) {
        canvas.drawLine(Offset(0, centerSliderY),
            Offset(size.width * thumbs[0], centerSliderY), sectionLineBrush);

        sectionTextPainter.layout(minWidth: 0, maxWidth: 600);

        sectionTextPainter.paint(
            canvas,
            Offset(
                size.width * thumbs[0] / 2 - sectionTextPainter.width / 2, 0));
      } else if (i == sections.length - 1) {
        canvas.drawLine(Offset(size.width * thumbs[i - 1], centerSliderY),
            Offset(size.width, centerSliderY), sectionLineBrush);

        var sectionWidth = size.width - size.width * thumbs.last;
        sectionTextPainter.layout(minWidth: 0, maxWidth: 600);

        sectionTextPainter.paint(
            canvas,
            Offset(
                size.width * thumbs.last +
                    sectionWidth / 2 -
                    sectionTextPainter.width / 2,
                0));
      } else {
        canvas.drawLine(Offset(size.width * thumbs[i - 1], centerSliderY),
            Offset(size.width * thumbs[i], centerSliderY), sectionLineBrush);

        var sectionWidth = size.width * thumbs[i] - size.width * thumbs[i - 1];
        sectionTextPainter.layout(minWidth: 0, maxWidth: 600);

        sectionTextPainter.paint(
            canvas,
            Offset(
                size.width * thumbs[i - 1] +
                    sectionWidth / 2 -
                    sectionTextPainter.width / 2,
                0));
      }
    }

    var thumbFill = Paint()..color = Colors.black;

    for (int i = 0; i < thumbs.length; i++) {
      var thumbRect = Rect.fromCenter(
          center: Offset(size.width * thumbs[i], centerSliderY),
          width: thumbWidth,
          height: thumbHeight);

      canvas.drawRRect(
          RRect.fromRectAndRadius(thumbRect, Radius.circular(10)), thumbFill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SliderSectionData {
  final Color color;
  final String label;
  final double percent;

  SliderSectionData(this.color, this.label, this.percent);
}
