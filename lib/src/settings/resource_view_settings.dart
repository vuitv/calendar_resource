import 'package:flutter/material.dart';

class ResourceViewSettings {
  const ResourceViewSettings({
    this.size = 200,
    this.visibleResourceCount = -1,
    this.showAvatar = true,
    this.displayNameTextStyle,
  })  : assert(size >= 0),
        assert(visibleResourceCount >= -1);

  final int visibleResourceCount;
  final TextStyle? displayNameTextStyle;
  final double size;
  final bool showAvatar;
}
