import 'dart:async';

import 'package:calendar/calendar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarState()) {
    on<CalendarChangeView>((event, emit) {
      emit(state.copyWith(view: event.view));
    });
    on<CalendarChangeCurrentDate>((event, emit) {
      emit(state.copyWith(currentDate: event.date));
    });
    on<CalendarChangeData>((event, emit) {
      emit(state.copyWith(dataSource: event.data));
    });

    final now = DateTime.now();
    currentTimeNotifier = ValueNotifier<int>(now.minute);

    Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.minute != currentTimeNotifier.value) {
        currentTimeNotifier.value = now.minute;
      }
    });
  }

  late ValueNotifier<int> currentTimeNotifier;

  void viewMode(CalendarViewMode view) {
    add(CalendarChangeView(view));
  }

  void addData(CalendarDataSource date) {
    add(CalendarChangeData(date));
  }

  void viewDate(DateTime date) {
    add(CalendarChangeCurrentDate(date));
  }

  void backward() {
    final date = state.currentDate.add(const Duration(days: -1));
    add(CalendarChangeCurrentDate(date));
  }

  void forward() {
    final date = state.currentDate.add(const Duration(days: 1));
    add(CalendarChangeCurrentDate(date));
  }
}

extension CalendarBlocExt on BuildContext {
  CalendarBloc get calendar => read<CalendarBloc>();
}
