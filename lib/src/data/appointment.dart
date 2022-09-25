import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Appointment extends Equatable {
  Appointment({
    Object? id,
    required this.startTime,
    required this.endTime,
    this.startTimeZone,
    this.endTimeZone,
    this.title = '',
    this.subject = '',
    this.resourceIds = const [],
    this.labels = const [],
    Color? color,
  })  : id = id ?? UniqueKey().hashCode,
        color = color ?? const Color(0xFFCBF0F8);

  Object id;
  String title;
  DateTime startTime;
  DateTime endTime;
  List<String> labels;
  String subject;
  Color color;
  String? startTimeZone;
  String? endTimeZone;
  List<Object> resourceIds;

  Duration get duration => endTime.difference(startTime);

  @override
  List<Object?> get props => [
        id,
        title,
        startTime,
        endTime,
        labels,
        subject,
        color,
        startTimeZone,
        endTimeZone,
        resourceIds,
      ];
}
