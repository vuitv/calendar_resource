import 'dart:math';

import 'package:flutter/material.dart';

import '../common/helper.dart';
import '../common/typedef.dart';
import '../data/appointment.dart';
import '../data/resource.dart';
import '../settings/time_slot_view_settings.dart';
import 'appointment_item.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({
    super.key,
    required this.appointments,
    required this.resources,
    required this.resourceItemWidth,
    required this.timeSlotViewSettings,
    required this.appointmentBuilder,
    required this.cellBorder,
  });

  final List<Appointment> appointments;
  final List<Resource> resources;
  final double resourceItemWidth;
  final TimeSlotViewSettings timeSlotViewSettings;
  final AppointmentBuilder? appointmentBuilder;
  final BorderSide cellBorder;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final resourceLength = resources.length;

    final timeIntervalHeight = timeSlotViewSettings.timeIntervalHeight;
    final totalTimeIntervalHeight = timeSlotViewSettings.totalTimeIntervalHeight;
    final minuteHeight = timeSlotViewSettings.minuteHeight;
    var startPosition = Offset.zero;
    final verticalPos = Offset(0, timeIntervalHeight);
    final horizontalPos = Offset(resourceItemWidth, 0);

    for (var i = 0; i < resourceLength; i++) {
      final resource = resources[i];
      final visibleAppointment = appointments.where(
        (e) => e.resourceIds.contains(resource.id),
      );

      for (var j = 0; j < visibleAppointment.length; j++) {
        final appointment = visibleAppointment.elementAt(j);
        final res = resources
            .where(
              (e) => appointment.resourceIds.contains(e.id),
            )
            .toList();
        final startTime = appointment.startTime;
        final startTimePosition = getTimeToPosition(
          Duration(hours: startTime.hour, minutes: startTime.minute),
          minuteHeight,
        );
        final maxWidth = resourceItemWidth * 0.98;
        final maxHeight = appointment.duration.inMinutes * minuteHeight;
        children.add(
          Positioned(
            left: startPosition.dx,
            top: startTimePosition,
            width: maxWidth,
            height: min(maxHeight, totalTimeIntervalHeight),
            child: DefaultAppointmentItem(
              appointment,
              colResource: resource,
              resources: res,
            ),
          ),
        );
        startPosition += verticalPos;
      }
      startPosition += horizontalPos;
    }

    return Stack(children: children);
  }
}
