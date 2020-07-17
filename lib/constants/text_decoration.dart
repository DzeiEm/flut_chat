import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
    color: Colors.tealAccent, fontWeight: FontWeight.bold, fontSize: 18.0);

const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    hintText: 'Type your text here',
    border: InputBorder.none);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(top: BorderSide(color: Colors.lightBlueAccent, width: 2)),
);

const kTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(32.0))
  ),
  
  hintText: 'enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
);
