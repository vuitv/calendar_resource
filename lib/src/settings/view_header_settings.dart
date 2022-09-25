import 'package:flutter/material.dart';

class ViewHeaderSettings {
  const ViewHeaderSettings({
    this.viewHeaderHeight = 64,
    this.backgroundColor,
    this.dateTextStyle,
    this.dayTextStyle,
  });

  final double viewHeaderHeight;
  final Color? backgroundColor;
  final TextStyle? dateTextStyle;
  final TextStyle? dayTextStyle;
}
