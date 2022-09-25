import 'package:calendar/calendar.dart';
import 'package:flutter/material.dart';

typedef ResourceBuilder = Widget Function(
  BuildContext context,
  Resource details,
);

typedef AppointmentBuilder = Widget Function(
  BuildContext context,
  Appointment details,
);
