import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/utils/event_provider.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  getEvents() async{
    EventProvider provider = EventProvider();
    await provider.getCalendarEvents();
    Navigator.pushReplacementNamed(context, '/home' , arguments: {
      'calendarEventList' : provider.mapList
    });
  }

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryAccent,
      body: SpinKitFadingCube(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
