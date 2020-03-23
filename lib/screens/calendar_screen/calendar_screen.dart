import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/calendar_screen/calendar_event_widget.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/widgets/empty_image_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final List<String> list;

  CalendarScreen(this.list);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<DateTime, List> _events;
  List _selectedEvents;
  CalendarController _calendarController;
  final String eventCollection = 'Events';
  DateTime _calenderDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    final _selectedDay = DateTime.now();

    _events = {DateTime.parse("2020-03-22"): widget.list ?? []};
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
  }

  Widget _buildEventList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _selectedEvents.map((event) => _buildEventRow(event)).toList(),
    );
  }

  Widget _buildEventRow(String event) {
    String title = '';
    String description = '';
    String category = '';
    String remindTime = '';

    List<String> eventDetails = event.split('-');
    eventDetails.asMap().forEach((index, element) {
      switch (index) {
        case 0:
          title = element;
          break;
        case 1:
          description = element;
          break;
        case 2:
          category = element;
          break;
        case 3:
          remindTime = element;
          break;
      }
    });

    return CalendarEventWidget(
      RemindEvent(
        title: title,
        description: description,
        category: category,
        remindTime: remindTime,
        remindDate: '',
      ),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _calenderDay = day;
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _buildTableCalendar(),
              Container(
                height: 20.0,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                width: MediaQuery.of(context).size.width,
                color: ThemeColor.primaryAccent.withAlpha(10),
                child: Text(
                  DateFormat.yMMMd().format(_calenderDay).toString(),
                  style: TextStyle(
                    color: ThemeColor.subTitleColor,
                  ),
                ),
              ),
              _selectedEvents.length == 0
                  ? EmptyImageWidget(
                      title: 'You have a free day.',
                      subtitle:
                          'Ready for some new events? Tap + to write them down.',
                      imagePath: 'assets/images/archive.png',
                      topPadding: 30.0,
                    )
                  : _buildEventList(),
            ],
          )),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: _onDaySelected,
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          centerHeaderTitle: true,
          titleTextStyle: TextStyle(
              color: ThemeColor.darkAccent,
              fontSize: 18,
              fontWeight: FontWeight.w500)),
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      rowHeight: 50,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontSize: 13),
        weekendStyle: TextStyle(color: Colors.red.withAlpha(200), fontSize: 13),
      ),
      calendarStyle: CalendarStyle(
        weekendStyle: TextStyle(color: Colors.black),
        selectedColor: ThemeColor.primary.withAlpha(500),
        todayColor: ThemeColor.primary.withAlpha(50),
        outsideDaysVisible: true,
      ),
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          return <Widget>[
            events.isNotEmpty
                ? Positioned(
                    right: _calendarController.isSelected(date) ? 1 : null,
                    bottom: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _calendarController.isSelected(date)
                              ? ThemeColor.primaryAccent
                              : ThemeColor.accent),
                      width: 15.0,
                      height: 15.0,
                      child: Center(
                        child: Text(
                          '${events.length}',
                          style: TextStyle().copyWith(
                            color: Colors.white,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ];
        },
      ),
    );
  }
}
