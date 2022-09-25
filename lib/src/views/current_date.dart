import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/calendar_bloc.dart';
import '../common/date_time.dart';

class CurrentDate extends StatelessWidget {
  const CurrentDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (p, c) => p.currentDate != c.currentDate,
      builder: (context, state) {
        final date = state.currentDate;
        final weekday = DateFormat.E().format(date);
        final day = date.day;
        final isToday = date.isToday;
        final color = Theme.of(context).primaryColor;
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                weekday.toUpperCase(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 1),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isToday ? color : null,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: isToday ? Colors.white : null,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
