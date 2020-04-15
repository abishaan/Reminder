import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/user.dart';
import 'package:reminder/screens/authenticate/reset_password.dart';
import 'package:reminder/screens/authenticate/sign_in.dart';
import 'package:reminder/screens/home_screen.dart';
import 'package:reminder/screens/loading_screen.dart';
import 'package:reminder/services/auth.dart';
import 'package:reminder/utils/theme_color.dart';

import 'screens/authenticate/register.dart';
import 'screens/authenticate/welcome_page.dart';

void main() => runApp(ReminderApp());

var themeData = ThemeData(
  accentColor: ThemeColor.primary,
  primaryColor: ThemeColor.primaryAccent,
  primarySwatch: ThemeColor.primaryAccentSwatch,
  textTheme: TextTheme(
    title: TextStyle(color: ThemeColor.primaryAccent),
  ),
);

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => LoadingScreen(),
          '/register': (context) => Register(),
          '/home': (context) => HomeScreen(),
          '/signin': (context) => SignIn(),
          '/welcome': (context) => Welcome(),
          '/forgotPassword': (context) => ResetPassword()
        },
        theme: themeData,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
