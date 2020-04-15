import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:provider/provider.dart';
import 'package:reminder/models/user.dart';
import 'package:reminder/screens/authenticate/authenticate.dart';
import 'package:reminder/screens/home_screen.dart';
import 'package:reminder/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class Wrapper1 extends StatelessWidget {
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

class _SignInState extends State<SignIn> {
  //instance of auth service
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 60.0, 0.0, 0.0),
                  child: Text('Hello',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 125.0, 0.0, 0.0),
                  child: Text('There',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(226.0, 125.0, 0.0, 0.0),
                  child: Text('.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple)),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 1.0, left: 20.0, right: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator:(val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (val){
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple))),
                    ),
                    TextFormField(
                      validator:(val) => val.length < 6 ? 'Enter a Password 6+ characters long' : null,
                      obscureText: true,
                      onChanged: (val){
                        setState(() {
                          password = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple))),
                    ),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () async {
                            Navigator.of(context).pushNamed('/forgotPassword');
                          }
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.purple,
                        color: Colors.purple,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async {
                            if(_formKey.currentState.validate()){
                              dynamic result  = await _auth.signInWithEmailAndPassword(email, password);
                              if(result == null){
                                setState(() {
                                  error = 'Could not Sign In with those credentials';
                                });
                              }
//                              else{
//                                Navigator.of(context).pushNamed('/home');
//                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton.icon(
                            onPressed: ()async{
                              dynamic res = await AuthService().loginWithGoogle();
                              if(res == null) {
                                print("error logging in with google");
                              }
//                              else{
//                                Navigator.of(context).pop();
//                              }
                            },
                            icon: Icon(FontAwesomeIcons.google,color: Colors.white),
                            color: Colors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            label: Text("Login With google",style: TextStyle(color: Colors.white))),
                        FlatButton.icon(
                            onPressed: ()async{
                              dynamic res = await AuthService().signUpWithFacebook();
                              if(res == null){
                                print("error logging in with facebook");
                              }
//                              else{
//                                Navigator.of(context).pop();
//                              }
                            },
                            icon: Icon(FontAwesomeIcons.facebook,color: Colors.white),
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            label: Text("Login With facebook",style: TextStyle(color: Colors.white)))
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton.icon(
                            onPressed: ()async {
                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                print('error signing in');
                              } else {
                                print('signed in');
                                print(result.uid);
                              }
                            },
                            icon: Icon(Icons.person,color: Colors.black),
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            label: Text("Login As a Guest",style: TextStyle(color: Colors.black))),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('New to Reminder?',
                          style:TextStyle(
                              fontFamily: 'Montserrat'
                          ),
                        ),
                        SizedBox(width: 3.0),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed('/register');
                          },
                          child: Text(' Register',
                            style: TextStyle(
                                color: Colors.purple,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline
                            ),),
                        )
                      ],
                    )

                  ],
                ),
              ))
        ],
      ),
    );
  }
}
