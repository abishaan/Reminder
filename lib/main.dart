import 'package:flutter/material.dart';
import 'package:reminder/screens/home_screen.dart';
import 'package:reminder/screens/loading_screen.dart';
import 'package:reminder/themes/theme_color.dart';

void main() => runApp(ReminderApp());

var themeData = ThemeData(
  accentColor: ThemeColor.primary,
  primaryColor: ThemeColor.primaryAccent,
);

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/home': (context) => HomeScreen(),
      },
      theme: themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
