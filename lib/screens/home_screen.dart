import 'dart:core';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/event.dart';
import 'package:reminder/screens/calendar_screen/calendar_screen.dart';
import 'package:reminder/screens/category_screen/category_screen.dart';
import 'package:reminder/screens/event_screen/event_screen.dart';
import 'package:reminder/services/event_service.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/screens/event_screen/create_event.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FloatingActionButtonLocation _buttonLocation =
      FloatingActionButtonLocation.endDocked;

  int _currentIndex = 0;
  bool _bottomNavHome = true;
  bool _bottomNavCalender = false;
  bool _bottomNavCategory = false;
  bool _bottomNavSetting = false;
  static Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    List<Widget> _tabItems = [
      EventScreen(),
      StreamProvider<List<RemindEvent>>.value(
        value: EventService().getAllEvents(),
        child: CalendarScreen(),
      ),
      CategoryScreen(),
      Center(child: Text('Settings')),
    ];

    return Scaffold(
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
            builder: (_) => CreateEventWidget(
              isEdit: false,
            ),
          );
        },
        tooltip: 'Add Event',
        backgroundColor: ThemeColor.primary,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3,
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
                    _bottomNavCategory = false;
                    _bottomNavSetting = false;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  MdiIcons.calendarClock,
                  size: 28,
                  color: _bottomNavCalender
                      ? ThemeColor.primary
                      : Colors.grey[300],
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                    _bottomNavHome = false;
                    _bottomNavCalender = true;
                    _bottomNavCategory = false;
                    _bottomNavSetting = false;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.dashboard,
                  size: 28,
                  color: _bottomNavCategory
                      ? ThemeColor.primary
                      : Colors.grey[300],
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                    _bottomNavHome = false;
                    _bottomNavCalender = false;
                    _bottomNavCategory = true;
                    _bottomNavSetting = false;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 28,
                  color:
                      _bottomNavSetting ? ThemeColor.primary : Colors.grey[300],
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                    _bottomNavHome = false;
                    _bottomNavCalender = false;
                    _bottomNavCategory = false;
                    _bottomNavSetting = true;
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
