import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggeInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

//
//  void getMessages() async{
//    final messages = await _firestore.collection('messages').getDocuments();
////    kiekviena zinute is firebase store
//    for(var message in messages.documents) {
//      print(message.data);
//    }
//  }

  void messagesStream() async {
//    snapshots tai list'as future event'u
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggeInUser = user;
        print(loggeInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '✿ Chat',
          style: TextStyle(fontSize: 30.0),
        ),
//        leading: null,
        backgroundColor: Colors.greenAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: InputDecoration(
                          hintText: 'type here',
                          focusColor: Colors.black,
                          hintStyle: TextStyle(color: Colors.black38)),
                      onChanged: (value) {
                        messageText = value;
                      },
                    ),
                  ),
                  FlatButton(
                    color: Colors.teal,
                    onPressed: () {
                      messageTextController.clear();
//                      prisijungiam prie tam tikro collection'o is firestore db
//                    ir pridedam text'a ir kas issiunte duomenys.
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggeInUser.email});
                      print(messageText);
                      print(loggeInUser.email);
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
//              stream'as reiskia is kur data ateina, o ji ateina is firebase db
      stream: _firestore.collection('messages').snapshots(),
//              builder reikia, kad turi pasakyti ka turi daryti tas builderis
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
//        reversed, reiskia, kad parasytos naujos zinutes bus nusiustos i screen'o gala
        final messages = snapshot.data.documents.reversed;
        List<MessageBuble> messageBubbles = [];
        for (var message in messages) {
          final messagesText = message.data['text'];
          final messageSender = message.data['sender'];
          final currentUser = loggeInUser.email;

          final messageBubble = MessageBuble(
            sender: messageSender,
            text: messagesText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBuble extends StatelessWidget {
  MessageBuble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.teal),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5,
            color: isMe ? Colors.tealAccent : Colors.pinkAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 12, color: isMe ? Colors.white : Colors.black54),
              ),
            ),
//            color: Colors.tealAccent,
          ),
        ],
      ),
    );
  }
}
