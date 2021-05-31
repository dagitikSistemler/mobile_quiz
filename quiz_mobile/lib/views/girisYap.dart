import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_mobile/helper/functions.dart';
import 'package:quiz_mobile/services/auth.dart';
import 'package:quiz_mobile/views/kayitOl.dart';
import 'package:quiz_mobile/widgets/widgets.dart';

import 'anasayfa.dart';

class GirisYap extends StatefulWidget {
  const GirisYap({Key key}) : super(key: key);

  @override
  _GirisYapState createState() => _GirisYapState();
}

class _GirisYapState extends State<GirisYap> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Email";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (mail) {
                        email = mail;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Password";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: blueButton(context: context, label: "Sign In"),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?  ", style: TextStyle(fontSize: 16)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => KayitOl()),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
    );
  }

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
      await authService.girisEmailvePassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Anasayfa()));
        }
      });
    }
  }
}
