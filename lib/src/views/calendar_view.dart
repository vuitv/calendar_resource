import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calendar_bloc.dart';
import '../common/date_time.dart';
import '../common/typedef.dart';
import '../settings/calendar_theme.dart';
import '../settings/resource_view_settings.dart';
import '../settings/time_slot_view_settings.dart';
import 'current_time_indicator.dart';
import 'day_view.dart';
import 'time_rule_view.dart';

class CalendarViewWidget extends StatelessWidget {
  const CalendarViewWidget({
    super.key,
    required this.theme,
    required this.timelineScrollCtrl,
    required this.timeSlotViewSettings,
    required this.resourceViewSettings,
    required this.appointmentBuilder,
  });

  final CalendarTheme theme;
  final ScrollController? timelineScrollCtrl;
  final TimeSlotViewSettings timeSlotViewSettings;
  final ResourceViewSettings resourceViewSettings;
  final AppointmentBuilder? appointmentBuilder;

  @override
  Widget build(BuildContext context) {
    final timeRulerSize = timeSlotViewSettings.timeRulerSize;
    final timeIntervalHeight = timeSlotViewSettings.totalTimeIntervalHeight;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final dayViewWidth = width - timeRulerSize;

        final startViewHeight = timeSlotViewSettings.startHeight;
        final initialScrollOffset = startViewHeight - 15;
        return ListView(
          padding: EdgeInsets.zero,
          controller: ScrollController(
            initialScrollOffset: initialScrollOffset,
          ),
          physics: const ClampingScrollPhysics(),
          children: [
            Stack(
              children: [
                Positioned(
                  top: 0,
                  left: timeRulerSize,
                  height: timeIntervalHeight,
                  width: dayViewWidth,
                  child: DayViewWidget(
                    theme: theme,
                    timelineScrollCtrl: timelineScrollCtrl,
                    timeSlotViewSettings: timeSlotViewSettings,
                    resourceViewSettings: resourceViewSettings,
                    appointmentBuilder: appointmentBuilder,
                  ),
                ),
                RepaintBoundary(
                  child: CustomPaint(
                    size: Size(timeRulerSize, timeIntervalHeight),
                    painter: TimeRulerView(
                      timeSlotViewSettings: timeSlotViewSettings,
                      cellBorder: theme.cellBorder,
                    ),
                  ),
                ),
                BlocBuilder<CalendarBloc, CalendarState>(
                  buildWhen: (p, c) => p.currentDate != c.currentDate,
                  builder: (context, state) {
                    if (!state.currentDate.isToday) return const SizedBox();
                    return RepaintBoundary(
                      child: CustomPaint(
                        size: Size(width, timeIntervalHeight),
                        painter: CurrentTimeIndicator(
                          timeIntervalSize: timeIntervalHeight,
                          timeSlotViewSettings: timeSlotViewSettings,
                          todayHighlightColor: theme.todayHighlightColor,
                          repaintNotifier: context.calendar.currentTimeNotifier,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
