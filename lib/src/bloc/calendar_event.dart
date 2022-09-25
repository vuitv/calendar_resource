part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class CalendarChangeView extends CalendarEvent {
  const CalendarChangeView(this.view);

  final CalendarViewMode view;

  @override
  List<Object?> get props => [view];
}

class CalendarChangeCurrentDate extends CalendarEvent {
  const CalendarChangeCurrentDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class CalendarChangeData extends CalendarEvent {
  const CalendarChangeData(this.data);

  final CalendarDataSource data;

  @override
  List<Object?> get props => [data];
}