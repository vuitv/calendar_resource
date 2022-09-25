part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  CalendarState({
    this.dataSource,
    this.view = CalendarViewMode.day,
    DateTime? currentDate,
  }) : currentDate = currentDate ?? DateTime.now();

  final CalendarViewMode view;
  final DateTime currentDate;
  final CalendarDataSource? dataSource;

  CalendarState copyWith({
    CalendarViewMode? view,
    DateTime? currentDate,
    CalendarDataSource? dataSource,
  }) {
    return CalendarState(
      view: view ?? this.view,
      currentDate: currentDate ?? this.currentDate,
      dataSource: dataSource ?? this.dataSource,
    );
  }

  @override
  List<Object?> get props => [
        view,
        currentDate,
        dataSource,
      ];
}
