import 'package:flutter/material.dart';

import '../settings/time_slot_view_settings.dart';

class TimeSlotView extends CustomPainter {
  TimeSlotView({
    required this.resourceItemWidth,
    required this.resourceCount,
    required this.timeSlotViewSettings,
    required this.cellBorder,
  });

  final double resourceItemWidth;
  final int resourceCount;
  final TimeSlotViewSettings timeSlotViewSettings;
  final BorderSide cellBorder;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final timeLinesCount = timeSlotViewSettings.timeIntervalLineCount;
    final timeIntervalHeight = timeSlotViewSettings.timeIntervalHeight;

    final linePainter = Paint()
      ..strokeWidth = cellBorder.width
      ..color = cellBorder.color;

    final startHeight = timeSlotViewSettings.startHeight;
    final endHeight = timeSlotViewSettings.endHeight;

    var verticalPos = timeIntervalHeight;
    for (var i = 0; i < timeLinesCount; i++) {
      if (verticalPos >= startHeight && verticalPos <= endHeight) {
        final start = Offset(0, verticalPos);
        final end = Offset(size.width, verticalPos);
        canvas.drawLine(start, end, linePainter);
      }
      verticalPos += timeIntervalHeight;
    }

    var horizontalPos = resourceItemWidth;
    for (var i = 0; i < resourceCount; i++) {
      final start = Offset(horizontalPos, 0);
      final end = Offset(horizontalPos, size.height);
      canvas.drawLine(start, end, linePainter);
      horizontalPos += resourceItemWidth;
    }
  }

  @override
  bool shouldRepaint(covariant TimeSlotView oldDelegate) {
    return oldDelegate.resourceCount != resourceCount;
  }
}
