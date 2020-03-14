import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  AuthState createState() => AuthState();
}

class AuthState extends State<Auth> {
  final usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          elevation: 0,
          backgroundColor: Color(0xfff7fafc),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 1, // 20%
              child: Container(),
            ),
            Expanded(
              flex: 6, // 60%
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/app-logo.png',
                      height: 50,
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(18.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(18.0),
                          ),
                          borderSide:
                              BorderSide(color: Color(0xff3f3f3f), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(18.0),
                          ),
                          borderSide:
                              BorderSide(color: Color(0xff689cf0), width: 1),
                        ),
                        hintText: 'username',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    GestureDetector(
                      onTap: () {
                        if ((usernameController.text).trim().isEmpty) {
                          Flushbar(
                              padding: EdgeInsets.all(15),
                              title: 'Username cannot be empty',
                              message: ' ',
                              borderRadius: 0,
                              backgroundColor: Color(0xff689cf0),
                              // leftBarIndicatorColor: Colors.black,
                              duration: Duration(seconds: 1),
                              forwardAnimationCurve:
                                  Curves.fastLinearToSlowEaseIn)
                            ..show(context);
                        } else if ((usernameController.text).trim().length <
                            4) {
                          Flushbar(
                              padding: EdgeInsets.all(15),
                              title: 'Username too short',
                              message: ' ',
                              borderRadius: 0,
                              backgroundColor: Color(0xff689cf0),
                              // leftBarIndicatorColor: Colors.black,
                              duration: Duration(seconds: 1),
                              forwardAnimationCurve:
                                  Curves.fastLinearToSlowEaseIn)
                            ..show(context);
                        } else {
                          Navigator.of(context).pushNamed('/chat', arguments: {
                            'username': usernameController.text
                                .trim()
                                .replaceAll(' ', '')
                          });
                          usernameController.text = '';
                        }
                      },
                      child: Image.asset(
                        'assets/login-btn.png',
                        height: 70,
                      ),
                    ),
                  ]),
            ),
            Expanded(
              flex: 1, // 20%
              child: Container(),
            )
          ],
        ));
  }
}
