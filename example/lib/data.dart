import 'dart:math';

import 'package:calendar_resource/calendar_resource.dart';
import 'package:flutter/material.dart';

final random = Random();

const List<String> _titleCollection = <String>[
  'John (860) 123-2345',
  'Bryan (820) 532-8768',
  'Robert (840) 643-3456',
  'Kenny (861) 865-7654',
  'Tia (850) 128-1236',
  'Theresa (123) 988-2316',
  'Brooklyn (100) 832-9876',
  'William (824) 234-0521',
];

const List<String> _subjectCollection = <String>[
  'Meeting',
  'Plan',
  'Haircut',
  'Manicure',
  'Nail',
];

const List<String> _nameCollection = <String>[
  'John',
  'Bryan',
  'Robert',
  'Kenny',
  'Tia',
  'Theresa',
  'Brooklyn',
  'James William',
  'Sophia',
  'Elena',
];

const List<String> _userImages = <String>[];

final List<Resource> _employeeCollection = List.generate(
  _nameCollection.length,
  (i) => Resource(
    displayName: _nameCollection[i],
    id: '000$i',
    color: colorCollection[random.nextInt(colorCollection.length)],
    image: i < _userImages.length ? NetworkImage(_userImages[i]) : null,
  ),
);

final List<Appointment> _shiftCollection = List.generate(
  _employeeCollection.length,
  (i) {
    final _employeeIds = <Object>[_employeeCollection[i].id];
    if (i == _employeeCollection.length - 1) {
      final index = random.nextInt(_employeeCollection.length);
      final employeeId = _employeeCollection[index].id;
      if (employeeId is String) {
        _employeeIds.add(employeeId);
      }
    }

    final date = DateTime.now();
    var startHour = 8 + random.nextInt(8);
    startHour = startHour >= 12 && startHour <= 13 ? startHour + 1 : startHour;
    final _shiftStartTime = DateTime(
      date.year,
      date.month,
      date.day,
      startHour,
      random.nextInt(30),
    );
    return Appointment(
      startTime: _shiftStartTime,
      endTime: _shiftStartTime.add(Duration(minutes: 30 + random.nextInt(90))),
      title: _titleCollection[random.nextInt(_titleCollection.length)],
      labels: List.generate(
        1 + random.nextInt(2),
        (index) => _subjectCollection[random.nextInt(_subjectCollection.length)],
      ),
      color: colorCollection[random.nextInt(colorCollection.length)],
      startTimeZone: '',
      endTimeZone: '',
      resourceIds: List.generate(
        1 + random.nextInt(3),
        (index) => _employeeCollection[random.nextInt(_employeeCollection.length)].id,
      ),
    );
  },
);

final getCalendarDataSource = CalendarDataSource(
  appointments: _shiftCollection,
  resources: _employeeCollection,
);

const List<Color> colorCollection = <Color>[
  Color(0xFFE8EAED),
  Color(0xFFCCFF90),
  Color(0xFFFFC0CB),
  Color(0xFFCBF0F8),
  Color(0xFFFFE4E1),
  Color(0xFFD7AEFB),
  Color(0xFF97C1A9),
];
