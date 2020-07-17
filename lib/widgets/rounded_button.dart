import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
//  Isstraukiam pasikartojancia dali
  final Color color;
  final String title;
  final Function onPressed;

  RoundedButton({this.color, this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(32.0),
        child: MaterialButton(
          child: Text(title),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
