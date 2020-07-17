import 'package:chat/constants/text_decoration.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth =
      FirebaseAuth.instance; // in order to create user with email and password
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
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
                height: 20,
              ),
              TextField(
                controller: TextEditingController(),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'email@email.com',
                    border: OutlineInputBorder(gapPadding: 4.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide:
                            BorderSide(color: Colors.yellowAccent, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ))),
                onChanged: (newValue) {
//                email'as bus tas ka ives vartotojas
//                taip issisaugo reiksme kuria ivede vartotojas
                  email = newValue;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.center,
//              hiden password
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'password',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide:
                            BorderSide(color: Colors.yellowAccent, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2))),
                onChanged: (newValue) {
//                passwordas bus tas koki ives vartotojas
//              taip issisaugo reiksme kuria ivede vartotojas
                  password = newValue;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                title: 'register',
                color: Colors.pink,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  print(email);
                  print(password);
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                  TextEditingController().clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
