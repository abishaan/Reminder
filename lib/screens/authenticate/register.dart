import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reminder/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String verifyPassword = '';
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
                  padding: EdgeInsets.fromLTRB(15.0, 80.0, 0.0, 0.0),
                  child: Text('Signup',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(264.0, 80.0, 0.0, 0.0),
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
                    SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (val){
                        setState(() {
                          password = val;
                          verifyPassword = val;
                        });
                      },
                      obscureText: true,
                      validator:(val) => val.length < 6 ? 'Enter a Password 6+ characters long' : null,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple))),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'VERIFY PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple))),
                    ),
                    SizedBox(height: 40.0),
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
                              dynamic result  = await _auth.registerWithEmailAndPassword(email, password);
                              if(result == null){
                                setState(() {
                                  error = 'please supply a valid email';
                                });
                              }else{
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              'REGISTER',
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
                            Navigator.of(context).pop();
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
                    Text(error,
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
    );
  }
}
