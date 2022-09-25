import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../appointment/appointment_view.dart';
import '../bloc/calendar_bloc.dart';
import '../common/helper.dart';
import '../common/typedef.dart';
import '../settings/calendar_theme.dart';
import '../settings/resource_view_settings.dart';
import '../settings/time_slot_view_settings.dart';
import 'time_slot_view.dart';

class DayViewWidget extends StatelessWidget {
  const DayViewWidget({
    super.key,
    required this.theme,
    this.timelineScrollCtrl,
    required this.timeSlotViewSettings,
    required this.resourceViewSettings,
    this.appointmentBuilder,
  });

  final CalendarTheme theme;
  final ScrollController? timelineScrollCtrl;
  final TimeSlotViewSettings timeSlotViewSettings;
  final ResourceViewSettings resourceViewSettings;
  final AppointmentBuilder? appointmentBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return SizedBox.expand(
        child: Scrollbar(
          controller: timelineScrollCtrl,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          child: ListView(
            controller: timelineScrollCtrl,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            children: [
              BlocBuilder<CalendarBloc, CalendarState>(
                builder: (context, state) {
                  final resources = state.dataSource?.resources ?? const [];
                  final appointments = state.dataSource?.appointments ?? const [];
                  final resourceItemWidth = getResourceItemWidth(
                    width: width,
                    resourceCount: resources.length,
                    resourceViewSettings: resourceViewSettings,
                  );
                  final resourceWidth = resourceItemWidth * resources.length;

                  return Stack(
                    children: [
                      RepaintBoundary(
                        child: CustomPaint(
                          size: Size(resourceWidth, height),
                          painter: TimeSlotView(
                            resourceCount: resources.length,
                            resourceItemWidth: resourceItemWidth,
                            timeSlotViewSettings: timeSlotViewSettings,
                            cellBorder: theme.cellBorder,
                          ),
                        ),
                      ),
                      RepaintBoundary(
                        child: SizedBox.fromSize(
                          size: Size(resourceWidth, height),
                          child: AppointmentView(
                            appointments: appointments,
                            resources: resources,
                            resourceItemWidth: resourceItemWidth,
                            timeSlotViewSettings: timeSlotViewSettings,
                            appointmentBuilder: appointmentBuilder,
                            cellBorder: theme.cellBorder,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
