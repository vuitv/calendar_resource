import 'package:equatable/equatable.dart';

import 'appointment.dart';
import 'resource.dart';

class CalendarDataSource extends Equatable {
  const CalendarDataSource({
    this.appointments = const [],
    this.resources = const [],
  });

  final List<Appointment> appointments;
  final List<Resource> resources;

  CalendarDataSource copyWith({
    List<Appointment>? appointments,
    List<Resource>? resources,
  }) {
    return CalendarDataSource(
      appointments: appointments ?? this.appointments,
      resources: resources ?? this.resources,
    );
  }

  @override
  List<Object?> get props => [
        appointments,
        resources,
      ];
}
