extension DateTimeExt on DateTime {
  bool get isToday {
    final now = DateTime.now();
    if (year == now.year && month == now.month && day == now.day) {
      return true;
    }
    return false;
  }
}
