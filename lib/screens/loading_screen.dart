import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reminder/themes/theme_color.dart';
import 'package:reminder/utils/event_provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  loadingTimer() async {
    Future.delayed(Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, '/home'));
  }

  @override
  void initState() {
    super.initState();
    loadingTimer();
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
