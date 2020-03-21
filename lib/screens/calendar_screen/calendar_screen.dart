import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/api/event_api.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/event_screen/event_list_widget.dart';
import 'package:reminder/screens/calendar_screen/special_event_widget.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/widgets/empty_image_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 1)): [
        'Event A2',
        'Event A2',
        'Event A2',
        'Event A2'
      ],
      _selectedDay: ['Event A2'],
      _selectedDay.add(Duration(days: 1)): ['Event A2'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animationController.forward();
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

  tapped(DateTime dateTime) {
    print('object' + dateTime.toString());
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
      onVisibleDaysChanged: _onVisibleDaysChanged,
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          centerHeaderTitle: true,
          titleTextStyle: TextStyle(
              color: ThemeColor.darkAccent,
              fontSize: 18,
              fontWeight: FontWeight.w500)),
      onHeaderTapped: tapped(DateTime.now()),
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

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('$first $last');
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents.map((event) => _buildEventRow(event)).toList(),
    );
  }

  Widget _buildEventRow(String event) {
    return SpecialEventWidget(
      RemindEvent(
        title: 'Appoinment',
        description: 'at hospital',
        category: 'personal',
        remindTime: '5:56 PM',
        remindDate: '',
      ),
    );
  }

  Widget _buildEventList2(BuildContext context) {
    EventAPI _eventAPI = EventAPI();
    return StreamBuilder<QuerySnapshot>(
        stream: _eventAPI = EventAPI().getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return snapshot.data.documents.length > 0
              ? Expanded(
                  child: ListView(
                    children: snapshot.data.documents
                        .asMap()
                        .map(
                          (index, data) => MapEntry(
                            index,
                                SpecialEventWidget(
                                    RemindEvent.fromSnapshot(data))

                          ),
                        )
                        .values
                        .toList(),
                  ),
                )
              : EmptyImageWidget(
                  title: 'You have a free day.',
                  subtitle:
                      'Ready for some new events? Tap + to write them down.',
                  imagePath: 'assets/images/archive.png');
        });
  }
}
