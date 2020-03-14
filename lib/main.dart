import 'package:flutter/material.dart';
import './screens/auth.dart';
import './screens/chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins Bold',
      ),
      home: Auth(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/auth': (BuildContext context) => new Auth(),
        '/chat': (BuildContext context) => new Chat(),
      },
    );
  }
}
