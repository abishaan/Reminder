import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reminder/screens/calendar_screen.dart';
import 'package:reminder/screens/event_screen/event_screen.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/screens/event_screen/create_event_widget.dart';

void main() => runApp(ReminderApp());

var themeData = ThemeData(
  accentColor: ThemeColor.primary,
  primaryColor: ThemeColor.primaryAccent,
);

class ReminderApp extends StatefulWidget {
  @override
  _ReminderAppState createState() => _ReminderAppState();
}

class _ReminderAppState extends State<ReminderApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FloatingActionButtonLocation _buttonLocation =
      FloatingActionButtonLocation.endDocked;

  int _currentIndex = 0;
  bool _bottomNavHome = true;
  bool _bottomNavCalender = false;
  bool _bottomNavTimer = false;

  List<Widget> _tabItems;

  @override
  void initState() {
    _tabItems = [
      EventScreen(),
      CalendarScreen(),
      Center(child: Text('Li')),
      Center(child: Text('Settings')),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _tabItems[_currentIndex],
      floatingActionButtonLocation: _buttonLocation,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            isScrollControlled: true,
            context: context,
            builder: (_) => CreateEventWidget(isEditMode: false),
          );
        },
        tooltip: 'Add Event',
        backgroundColor: ThemeColor.primary,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
          margin: EdgeInsets.only(right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: _bottomNavHome ? ThemeColor.primary : Colors.grey[300],
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                    _bottomNavHome = true;
                    _bottomNavCalender = false;
                    _bottomNavTimer = false;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  MdiIcons.calendarClock,
                  size: 26,
                  color: _bottomNavCalender
                      ? ThemeColor.primary
                      : Colors.grey[300],
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                    _bottomNavHome = false;
                    _bottomNavCalender = true;
                    _bottomNavTimer = false;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.alarm_add,
                  size: 30,
                  color:
                      _bottomNavTimer ? ThemeColor.primary : Colors.grey[300],
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                    _bottomNavHome = false;
                    _bottomNavCalender = false;
                    _bottomNavTimer = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
