import 'package:flutter/material.dart';

import '../data/appointment.dart';
import '../data/resource.dart';

typedef ResourceBuilder = Widget Function(
  BuildContext context,
  Resource details,
);

typedef AppointmentBuilder = Widget Function(
  BuildContext context,
  Appointment details,
);
