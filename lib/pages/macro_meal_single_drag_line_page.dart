import 'package:flutter/material.dart';

class MacroMealSingleDragLinePage extends StatefulWidget {
  const MacroMealSingleDragLinePage({Key? key}) : super(key: key);

  @override
  _MacroMealSingleDragLinePageState createState() =>
      _MacroMealSingleDragLinePageState();
}

class _MacroMealSingleDragLinePageState
    extends State<MacroMealSingleDragLinePage> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderTheme(
        data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[100],
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 4.0,
            thumbShape: CustomSliderThumbRect(
              thumbHeight: 60,
              thumbRadius: 20,
              min: 0,
              max: 100,
            ),
            thumbColor: Colors.redAccent,
            // overlayColor: Colors.red.withAlpha(32),
            // overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            // tickMarkShape: RoundSliderTickMarkShape(),
            // activeTickMarkColor: Colors.red[700],
            // inactiveTickMarkColor: Colors.red[100],
            showValueIndicator: ShowValueIndicator.never
            // valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            // valueIndicatorColor: Colors.redAccent,
            // valueIndicatorTextStyle: TextStyle(
            //   color: Colors.white,
            // ),
            ),
        child: Slider(
          value: _value,
          min: 0,
          max: 100,
          divisions: 10,
          label: '$_value',
          onChanged: (value) {
            setState(
              () {
                _value = value;
              },
            );
          },
        ),
      ),
    );
  }
}

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final double thumbHeight;
  final int min;
  final int max;

  const CustomSliderThumbRect({
    required this.thumbRadius,
    required this.thumbHeight,
    required this.min,
    required this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.2, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = sliderTheme!.activeTrackColor! //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontSize: thumbHeight * .3,
            fontWeight: FontWeight.w700,
            color: sliderTheme.thumbColor,
            height: 1),
        text: '${getValue(value!)}');
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);

    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
