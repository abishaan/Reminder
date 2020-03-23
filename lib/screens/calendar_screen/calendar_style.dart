import 'package:flutter/material.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:table_calendar/table_calendar.dart';

final calendarWeekStyle = DaysOfWeekStyle(
  weekdayStyle: TextStyle(fontSize: 13),
  weekendStyle: TextStyle(color: Colors.red.withAlpha(200), fontSize: 13),
);

final calendarStyle = CalendarStyle(
  weekendStyle: TextStyle(color: Colors.black),
  selectedColor: ThemeColor.primary.withAlpha(500),
  todayColor: ThemeColor.primary.withAlpha(50),
  outsideDaysVisible: true,
);

final calendarHeaderStyle = HeaderStyle(
  formatButtonVisible: false,
  centerHeaderTitle: true,
  titleTextStyle: TextStyle(
    color: ThemeColor.darkAccent,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
);

final calendarFormats = {
  CalendarFormat.month: '',
  CalendarFormat.week: '',
};