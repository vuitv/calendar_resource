import 'package:calendar/src/views/current_date.dart';
import 'package:flutter/material.dart';

import '../settings/view_header_settings.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({
    super.key,
    required this.timeRulerSize,
    required this.viewHeaderSettings,
    required this.cellBorder,
  });

  final double timeRulerSize;
  final ViewHeaderSettings viewHeaderSettings;
  final BorderSide cellBorder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: viewHeaderSettings.viewHeaderHeight,
          decoration: BoxDecoration(
            color: viewHeaderSettings.backgroundColor ?? Colors.white,
            border: Border(
              top: cellBorder,
              bottom: cellBorder,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff000000).withOpacity(0.08),
                offset: const Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          width: timeRulerSize,
          height: viewHeaderSettings.viewHeaderHeight,
          child: const CurrentDate(),
        ),
        Positioned(
          top: 0,
          left: timeRulerSize - cellBorder.width - cellBorder.width / 2,
          width: cellBorder.width,
          height: viewHeaderSettings.viewHeaderHeight,
          child: VerticalDivider(
            width: cellBorder.width,
            thickness: cellBorder.width,
            color: cellBorder.color,
          ),
        ),
      ],
    );
  }
}
