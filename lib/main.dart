import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reminder/screens/calendar_screen.dart';
import 'package:reminder/screens/event_screen.dart';
import 'package:reminder/utils/theme_color.dart';

void main() => runApp(ReminderApp());

class ReminderApp extends StatefulWidget {
  @override
  _ReminderAppState createState() => _ReminderAppState();
}

class _ReminderAppState extends State<ReminderApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  static const homeMenuItems = ['Manage Categories', 'Settings'];

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
  String _screenTitle = 'Remind Me!';
  List<Widget> _tabItems;

  @override
  void initState() {
    _tabItems = [
      EventScreen(),
      CalendarScreen(refresh),
      Center(child: Text('Li')),
      Center(child: Text('Settings')),
    ];
    super.initState();
  }

  refresh(dynamic title) {
    setState(() {
      _screenTitle = title;
    });
  }

  final List<PopupMenuItem> _popupHomeMenuItems = HomePage.homeMenuItems
      .map((value) => PopupMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ThemeColor.titleColor),
        title: Text(
          _screenTitle,
          style: TextStyle(color: ThemeColor.titleColor),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          _bottomNavHome
              ? PopupMenuButton(
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext context) => _popupHomeMenuItems,
                )
              : SizedBox()
        ],
      ),
      backgroundColor: Colors.white,
      body: _tabItems[_currentIndex],
      drawer: Drawer(),
      floatingActionButtonLocation: _buttonLocation,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        backgroundColor: ThemeColor.primary,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
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
                    _screenTitle = 'Remind Me!';
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
                    _screenTitle = 'Calendar';
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
