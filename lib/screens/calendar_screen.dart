import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final Function refresh;
  CalendarScreen(this.refresh);

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerVisible: false,
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      
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
    widget.refresh('hello');
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents.map((event) => _buildEventRow(event)).toList(),
    );
  }

  Widget _buildEventRow(String event) {
    print('-----------' + event.isNotEmpty.toString());
    return Card(
      elevation: 2,
      shape: Border(
        left: BorderSide(
          color: Colors.deepPurpleAccent,
          width: 5,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 120,
        child: ListTile(
          title: Container(
            padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  event.toString(),
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 4,
                        color: ThemeColor.accent.withAlpha(700),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
            child: Column(
              children: <Widget>[
                Text(
                  'Lorem Lorem Lorem Lorem Lorem Lorem  Lorem Lorem Lorem Lorem Lorem Lorem LoremLorem Lorem LoremLoremLorem LoremLorem',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 4),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 6,
                        width: 6,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 4,
                              color: Colors.deepPurpleAccent.withAlpha(700),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Meeting:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          '10.30 am',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
