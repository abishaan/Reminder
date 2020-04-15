import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reminder/services/auth.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool emailSent;
  bool unsucessfulMsg;
  String email = '';
  String warning   = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 0.0),
            showSuccessfulMsg(emailSent),
            showAlert(unsucessfulMsg),
            SizedBox(height: 10.0),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 80.0, 0.0, 0.0),
                    child: Text('Forgot Password',
                        style: TextStyle(
                            fontSize: 45.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(360.0, 50.0, 0.0, 0.0),
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
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60.0),
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
                      SizedBox(height: 50.0),
                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.purple,
                          color: Colors.purple,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: ()async{
                              if(_formKey.currentState.validate()){
                                dynamic result = await _auth.sendPasswordResetEmail(email);//await _auth.signInWithEmailAndPassword(email, password);
                                if(result == null){
                                  setState(() {
                                    emailSent = true;
                                  });
                                }else if(result != null){
                                  unsucessfulMsg = true;
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                'RESET',
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
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed('/signin');
                            },
                            child:
                            Center(
                              child: Text('GO BACK',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'
                                ),),

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(warning,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize:16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
  Widget showAlert(bool unsucessfulMsg){
    if(unsucessfulMsg == true){
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.only(right: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child:Text(' '+warning)
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }
  Widget showSuccessfulMsg(bool emailSent){
    if(emailSent == true){
      return Container(
        color: Colors.green,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.done_all),
            Expanded(child:Text('A password reset link has been sent to '+email)),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  Navigator.of(context).pushNamed('/forgotPassword');
                },
              ),
            )

          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }
}
