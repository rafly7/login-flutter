import 'package:flutter/material.dart';

var outlineInput = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xBBB437BC), width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(25.0))
);

var inputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0)
  ),
  enabledBorder: outlineInput,
  focusedBorder: outlineInput
);

