import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  String username;
  SocketIO io;
  List<Map> messages;
  List data;
  num vh, vw;
  TextEditingController messageController;
  ScrollController scrollController;
  bool isFromMe = true;

  @override
  void initState() {
    messageController = TextEditingController();
    scrollController = ScrollController();
    username = '';
    messages = List<Map>();
    io = SocketIOManager()
        .createSocketIO('https://openchat-backend.herokuapp.com/', '/');
    io.init();

    io.subscribe('message_receive', (resData) {
      print(resData.runtimeType);
      Map data = json.decode(resData);
      print('MAP');
      print(data);
      // var Obj = {}
      // Obj["username"] = resData['']
      setState(() {
        messages.add({'username': data['username'], 'text': data['text']});
      });

      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });

    io.connect();
    super.initState();
  }

  Widget buildMessage(int index) {
    String msgUsername = messages[index]['username'];
    String msgText = messages[index]['text'];
    bool isFromMe = msgUsername == username ? true : false;
    // isFromMe = !isFromMe;

    if (isFromMe) {
      return Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              '@$msgUsername',
              style: TextStyle(color: Color(0xff689cf0)),
            ),
            Padding(padding: EdgeInsets.all(2)),
            Container(
              constraints: BoxConstraints(minWidth: 50, maxWidth: 200),
              padding: EdgeInsets.fromLTRB(18, 16, 18, 16),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  color: const Color.fromRGBO(63, 63, 63, 0.01),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(18.0),
                    topRight: const Radius.circular(18.0),
                    bottomRight: const Radius.circular(18.0),
                    bottomLeft: const Radius.circular(18.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff689cf0),
                    )
                  ]),
              child: Text(msgText, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/user.png',
              height: 60,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '@$msgUsername',
                    style: TextStyle(color: Color(0xff689cf0)),
                  ),
                  Padding(padding: EdgeInsets.all(2)),
                  Container(
                    constraints: BoxConstraints(minWidth: 50, maxWidth: 200),
                    padding: EdgeInsets.fromLTRB(18, 16, 18, 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        color: const Color.fromRGBO(63, 63, 63, 0.01),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(18.0),
                          topRight: const Radius.circular(18.0),
                          bottomRight: const Radius.circular(18.0),
                          bottomLeft: const Radius.circular(18.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                          )
                        ]),
                    child: Text(msgText),
                  ),
                ])
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      username = arguments['username'];
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '@$username',
          style: TextStyle(color: Color(0xff689cf0), shadows: <Shadow>[
            Shadow(
              offset: Offset(4.0, 3.0),
              blurRadius: 0,
              color: Color.fromRGBO(0, 0, 0, 0.07),
            ),
          ]),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffffffff),
        leading: new IconButton(
            icon: new Icon(
              Icons.supervised_user_circle,
              color: Color(0xff689cf0),
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.clear_all),
              color: Color(0xff689cf0),
              onPressed: () {
                setState(() {
                  messages.clear();
                });
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return buildMessage(index);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
            ),
            child: Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(63, 63, 63, 0.3),
                      offset: Offset(
                        0.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(18.0),
                    topRight: const Radius.circular(18.0),
                    bottomRight: const Radius.circular(18.0),
                    bottomLeft: const Radius.circular(18.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0), width: 1),
                            ),
                            hintText: 'type a message'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if ((messageController.text).trim().isNotEmpty) {
                          io.sendMessage(
                              'message',
                              json.encode({
                                'username': username,
                                'text': messageController.text,
                              }));
                          messageController.text = '';
                        }
                      },
                      child: Image.asset(
                        'assets/send-btn.png',
                        height: 50,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
