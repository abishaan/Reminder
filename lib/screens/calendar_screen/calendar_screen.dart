import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/calendar_screen/special_event_widget.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final List<String> list;

  CalendarScreen(this.list);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  final String eventCollection = 'Events';

  @override
  void initState() {
    super.initState();

    final _selectedDay = DateTime.now();

//    RemindEvent event = RemindEvent(
//      title: 'Appoinment 1',
//      description: 'at hospital',
//      category: 'personal',
//      remindTime: '5:56 PM',
//      remindDate: '2020-03-16 00:00:00.000',
//    );
//
//    RemindEvent event2 = RemindEvent(
//      title: 'Appoinment 2',
//      description: 'at hosp  ital',
//      category: 'personal',
//      remindTime: '15:56 PM',
//      remindDate: '2020-03-12 00:00:00.000',
//    );

    _events = {DateTime.parse("2020-03-22"): widget.list ?? []};
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animationController.forward();
  }

  Widget _buildEventList() {
    return ListView(
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

    return SpecialEventWidget(
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
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildTableCalendar(),
                // _buildTableCalendarWithBuilders(),
                const SizedBox(height: 8.0),
                Expanded(child: _buildEventList()),
              ],
            ),
          ),
        ),
      ),
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
