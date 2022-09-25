import 'dart:math';

import '../settings/resource_view_settings.dart';

double getResourceItemWidth({
  required double width,
  required int resourceCount,
  required ResourceViewSettings resourceViewSettings,
}) {
  final visibleResourceCount = resourceViewSettings.visibleResourceCount;

  if (visibleResourceCount > 0 || resourceCount == 0) {
    return width / visibleResourceCount;
  }

  final itemWidth = resourceViewSettings.size;
  final viewWidth = resourceCount * itemWidth;
  final minItemWidth = width / 5;
  final countItemWidth = width / resourceCount;
  return viewWidth < width ? countItemWidth : max(itemWidth, minItemWidth);
}

double getTimeToPosition(
  Duration duration,
  double minuteHeight,
) {
  const startDuration = Duration.zero;
  final difference = duration - startDuration;
  return difference.isNegative ? 0 : difference.inMinutes * minuteHeight;
}
