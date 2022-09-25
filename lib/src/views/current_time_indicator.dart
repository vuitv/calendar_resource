import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../common/helper.dart';
import '../settings/time_slot_view_settings.dart';

class CurrentTimeIndicator extends CustomPainter {
  CurrentTimeIndicator({
    required this.timeIntervalSize,
    required this.timeSlotViewSettings,
    required this.todayHighlightColor,
    ValueNotifier<int>? repaintNotifier,
  }) : super(repaint: repaintNotifier);

  final double timeIntervalSize;
  final TimeSlotViewSettings timeSlotViewSettings;
  final Color todayHighlightColor;

  @override
  void paint(Canvas canvas, Size size) {
    final now = DateTime.now();
    final hours = now.hour;
    final minutes = now.minute;

    final timeRulerSize = timeSlotViewSettings.timeRulerSize;
    final minuteHeight = timeSlotViewSettings.minuteHeight;
    final currentTimePosition = getTimeToPosition(
      Duration(hours: hours, minutes: minutes),
      minuteHeight,
    );

    final viewSize = size.width - timeRulerSize;
    final startYPosition = currentTimePosition;
    final viewStartPosition = timeRulerSize;
    final viewEndPosition = viewStartPosition + viewSize;
    final startXPosition = viewStartPosition < 5 ? 5 : viewStartPosition;

    final painter = Paint()
      ..color = todayHighlightColor
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..strokeWidth = 1
      ..color = Colors.black.withOpacity(0.4)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas
      ..drawLine(
        Offset(viewStartPosition, startYPosition),
        Offset(viewEndPosition, startYPosition),
        shadowPaint,
      )
      ..drawLine(
        Offset(viewStartPosition, startYPosition),
        Offset(viewEndPosition, startYPosition),
        painter,
      );

    final indicatorSize = timeRulerSize * 0.85;
    const indicatorHeight = 16.0;
    final center = Offset(startXPosition - indicatorSize / 2, startYPosition);
    final rect = Rect.fromCenter(
      center: center,
      width: indicatorSize,
      height: indicatorHeight,
    );

    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas
      ..drawRRect(rRect, shadowPaint)
      ..drawRRect(rRect, painter);

    final timeTextStyle = timeSlotViewSettings.timeTextStyle;
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: timeTextStyle.fontSize,
    );
    final timeFormat = timeSlotViewSettings.timeFormat;
    final time = intl.DateFormat(timeFormat).format(now);
    final textSpan = TextSpan(
      text: time.toLowerCase(),
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: indicatorSize,
      );
    final xCenter = (rect.width - textPainter.width) / 2;
    final yCenter = (rect.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, rect.topLeft + offset);
  }

  @override
  bool? hitTest(Offset position) => false;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
