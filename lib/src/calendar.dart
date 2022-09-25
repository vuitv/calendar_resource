import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/calendar_bloc.dart';
import 'common/helper.dart';
import 'common/typedef.dart';
import 'resource/resource_view.dart';
import 'settings/calendar_theme.dart';
import 'settings/resource_view_settings.dart';
import 'settings/time_slot_view_settings.dart';
import 'settings/view_header_settings.dart';
import 'views/calendar_view.dart';
import 'views/header_view.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    this.theme = const CalendarTheme.light(),
    this.viewHeaderSettings = const ViewHeaderSettings(),
    this.timeSlotViewSettings = const TimeSlotViewSettings(),
    this.resourceViewSettings = const ResourceViewSettings(),
    this.resourceBuilder,
    this.appointmentBuilder,
  });

  final CalendarTheme theme;

  final ViewHeaderSettings viewHeaderSettings;
  final TimeSlotViewSettings timeSlotViewSettings;
  final ResourceViewSettings resourceViewSettings;

  final ResourceBuilder? resourceBuilder;
  final AppointmentBuilder? appointmentBuilder;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final resourceScrollCtrl = ScrollController();
  final timelineScrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    resourceScrollCtrl.addListener(_updateScrollView);
    timelineScrollCtrl.addListener(_updateScrollView);
  }

  @override
  void dispose() {
    resourceScrollCtrl.removeListener(_updateScrollView);
    timelineScrollCtrl.removeListener(_updateScrollView);
    resourceScrollCtrl.dispose();
    timelineScrollCtrl.dispose();
    super.dispose();
  }

  void _updateScrollView() {
    if (!resourceScrollCtrl.hasClients || !timelineScrollCtrl.hasClients) {
      return;
    }
    if (resourceScrollCtrl.offset != timelineScrollCtrl.offset) {
      resourceScrollCtrl.jumpTo(timelineScrollCtrl.offset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final timeRulerSize = widget.timeSlotViewSettings.timeRulerSize;
        final viewHeaderHeight = widget.viewHeaderSettings.viewHeaderHeight;
        return Container(
          width: width,
          height: height,
          color: widget.theme.backgroundColor,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                height: viewHeaderHeight,
                child: Stack(
                  children: [
                    HeaderView(
                      timeRulerSize: timeRulerSize,
                      viewHeaderSettings: widget.viewHeaderSettings,
                      cellBorder: widget.theme.cellBorder,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: timeRulerSize,
                      child: BlocBuilder<CalendarBloc, CalendarState>(
                        builder: (context, state) {
                          final resources = state.dataSource?.resources ?? const [];
                          final resourceViewWidth = width - timeRulerSize;
                          final resourceItemWidth = getResourceItemWidth(
                            width: resourceViewWidth,
                            resourceCount: resources.length,
                            resourceViewSettings: widget.resourceViewSettings,
                          );
                          return ResourceViewWidget(
                            resources: resources,
                            scrollController: resourceScrollCtrl,
                            resourceItemWidth: resourceItemWidth,
                            resourceViewSettings: widget.resourceViewSettings,
                            resourceBuilder: widget.resourceBuilder,
                            cellBorder: widget.theme.cellBorder,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: viewHeaderHeight,
                right: 0,
                left: 0,
                bottom: 0,
                child: CalendarViewWidget(
                  theme: widget.theme,
                  timelineScrollCtrl: timelineScrollCtrl,
                  timeSlotViewSettings: widget.timeSlotViewSettings,
                  resourceViewSettings: widget.resourceViewSettings,
                  appointmentBuilder: widget.appointmentBuilder,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
