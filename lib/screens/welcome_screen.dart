import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
//  const nustatomas tada, kai properties nagali buti pakeistas.
  static const String id = 'welcome_screen';

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TypewriterAnimatedTextKit(text: ['Flash Chat', 'new chat']),
      ),
      backgroundColor: Colors.black54,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 400,
                  child: Image.asset('images/login.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'login',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.tealAccent,
              title: 'register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

