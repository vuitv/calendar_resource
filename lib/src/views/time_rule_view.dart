import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../calendar_resource.dart';

class TimeRulerView extends CustomPainter {
  TimeRulerView({
    required this.timeSlotViewSettings,
    required this.cellBorder,
  });

  final TimeSlotViewSettings timeSlotViewSettings;
  final BorderSide cellBorder;

  final Paint _linePainter = Paint();
  final TextPainter _textPainter = TextPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final offset = cellBorder.width;
    double xPosition, yPosition;

    final timeLinesCount = timeSlotViewSettings.timeIntervalLineCount;
    final timeIntervalHeight = timeSlotViewSettings.timeIntervalHeight;
    final timeIntervalInMinutes = timeSlotViewSettings.timeIntervalInMinutes;

    xPosition = 0.0;
    yPosition = timeIntervalHeight;
    _linePainter
      ..strokeWidth = offset
      ..color = cellBorder.color;

    final lineXPosition = size.width - offset;
    canvas.drawLine(
      Offset(lineXPosition, 0),
      Offset(lineXPosition, size.height),
      _linePainter,
    );

    _textPainter
      ..textDirection = TextDirection.ltr
      ..textWidthBasis = TextWidthBasis.longestLine
      ..textScaleFactor = 1;

    final timeTextStyle = timeSlotViewSettings.timeTextStyle;

    for (var i = 1; i <= timeLinesCount; i++) {
      final minute = i * timeIntervalInMinutes;
      final date = DateTime(2022, 1, 1, 0, minute);
      final timeFormat = intl.DateFormat(timeSlotViewSettings.timeFormat);
      final time = timeFormat.format(date);
      final span = TextSpan(
        text: time.toLowerCase(),
        style: timeTextStyle,
      );

      final cellWidth = size.width;

      _textPainter
        ..text = span
        ..layout(maxWidth: cellWidth);

      var startXPosition = (cellWidth - _textPainter.width) / 2;
      if (startXPosition < 0) {
        startXPosition = 0;
      }

      final startYPosition = yPosition - (_textPainter.height / 2);

      _textPainter.paint(canvas, Offset(startXPosition, startYPosition));

      final start = Offset(size.width - (startXPosition / 2), yPosition);
      final end = Offset(size.width, yPosition);
      canvas.drawLine(start, end, _linePainter);
      yPosition += timeIntervalHeight;
      if (yPosition.round() == size.height.round()) {
        break;
      }
    }
  }

  @override
  bool shouldRepaint(TimeRulerView oldDelegate) {
    final oldWidget = oldDelegate;
    return oldWidget.timeSlotViewSettings != timeSlotViewSettings || oldWidget.cellBorder != cellBorder;
  }
}
