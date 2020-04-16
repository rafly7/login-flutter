import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final title;
  final color;
  final onPressed;
  const RoundedButton({Key key, this.title, this.color, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Text(
        title,
      ),
    );
  }
}