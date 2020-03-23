import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/calendar_screen/calendar_event_widget.dart';
import 'package:reminder/screens/calendar_screen/calendar_style.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/widgets/empty_image_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final Map<DateTime, List<String>> mapList;

  CalendarScreen(this.mapList, {Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<DateTime, List<String>> _events = new Map();
  List _selectedEvents;
  CalendarController _calendarController;
  DateTime _calenderDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.mapList.forEach((date, dateList) => _events[date] = dateList ?? []);
    _selectedEvents = _events[DateTime.parse(DateFormat("yyyy-MM-dd")
            .parse(_calenderDay.toString())
            .toString())] ??
        [];
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
      headerStyle: calendarHeaderStyle,
      availableCalendarFormats: calendarFormats,
      rowHeight: 50,
      daysOfWeekStyle: calendarWeekStyle,
      calendarStyle: calendarStyle,
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          return <Widget>[_calendarIndicator(date, events)];
        },
      ),
    );
  }

  Widget _calendarIndicator(DateTime date, List<dynamic> events) {
    return events.isNotEmpty
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
        : SizedBox();
  }
}
