import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSlotViewSettings {
  const TimeSlotViewSettings({
    this.startHour = const TimeOfDay(hour: 8, minute: 0),
    this.endHour = const TimeOfDay(hour: 17, minute: 0),
    this.timeFormat = 'h:mm a',
    this.timeInterval = const Duration(minutes: 30),
    this.timeRulerSize = 76,
    this.timeIntervalHeight = 60,
    this.timeTextStyle = const TextStyle(
      fontSize: 11,
      color: Colors.black54,
    ),
  })  : assert(timeIntervalHeight >= -1),
        assert(timeRulerSize >= -1);

  final TimeOfDay startHour;
  final TimeOfDay endHour;
  final Duration timeInterval;
  final double timeIntervalHeight;
  final String timeFormat;
  final double timeRulerSize;
  final TextStyle timeTextStyle;

  int get totalMinutes => 24 * 60;

  int get timeIntervalInMinutes {
    final timeIntervalMinutes = timeInterval.inMinutes;
    if (timeIntervalMinutes >= 0 && timeIntervalMinutes <= totalMinutes && totalMinutes % timeIntervalMinutes == 0) {
      return timeIntervalMinutes;
    } else if (timeIntervalMinutes >= 0 && timeIntervalMinutes <= totalMinutes) {
      return _getNearestValue(timeIntervalMinutes, totalMinutes);
    } else {
      return 60;
    }
  }

  int get timeIntervalLineCount {
    return totalMinutes ~/ timeIntervalInMinutes;
  }

  double get totalTimeIntervalHeight {
    return timeIntervalHeight * timeIntervalLineCount;
  }

  double get minuteHeight {
    return totalTimeIntervalHeight / totalMinutes;
  }

  double get startHeight {
    final minus = startHour.hour * 60;
    return minus * minuteHeight;
  }

  double get endHeight {
    final minus = endHour.hour * 60;
    return minus * minuteHeight;
  }

  static int _getNearestValue(int timeInterval, int totalMinutes) {
    final nextTimeInterval = timeInterval + 1;
    if (totalMinutes % nextTimeInterval == 0) {
      return nextTimeInterval;
    }

    return _getNearestValue(timeInterval, totalMinutes);
  }
}
