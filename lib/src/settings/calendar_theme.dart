import 'package:flutter/material.dart';

class CalendarTheme {
  const CalendarTheme({
    required this.todayHighlightColor,
    required this.backgroundColor,
    required this.cellBorder,
  });

  const CalendarTheme.light({
    this.todayHighlightColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.cellBorder = const BorderSide(
      width: 0.5,
      color: Color(0x29546E7A),
    ),
  });

  final Color todayHighlightColor;
  final Color backgroundColor;
  final BorderSide cellBorder;
}
