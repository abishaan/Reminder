import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/user.dart';
import 'package:reminder/screens/authenticate/authenticate.dart';
import 'package:reminder/screens/home_screen.dart';

class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return home or authentication
    if (user == null){
      return Authenticate();
    }else{
      return HomeScreen();
    }
  }
}
