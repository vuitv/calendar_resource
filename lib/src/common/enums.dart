enum CalendarViewMode {
  day,
  week,
  month,
  schedule,
}

enum MonthAppointmentDisplayMode {
  indicator,
  appointment,
  none,
}

enum RecurrenceType {
  daily,
  weekly,
  monthly,
  yearly,
}

enum RecurrenceRange {
  endDate,
  noEndDate,
  count,
}

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

enum CalendarElement {
  header,
  viewHeader,
  calendarCell,
  appointment,
  agenda,
  allDayPanel,
  moreAppointmentRegion,
  resourceHeader,
}

enum CalendarDataSourceAction {
  add,
  remove,
  reset,
  addResource,
  removeResource,
  resetResource,
}

enum ViewNavigationMode {
  snap,
  none,
}

enum AppointmentType {
  changedOccurrence,
  normal,
  occurrence,
  pattern,
}
