import 'package:flutter/material.dart';
import 'package:smm_project/utils/style_constant.dart';

class CustomTextFormField extends StatelessWidget {
  final inputType;
  final hintText;
  final prefixIcon;
  final suffixIcon;
  final focusNode;
  final controller;
  final obscureText;
  const CustomTextFormField({
    Key key,
    this.inputType,
    this.hintText,
    this.focusNode,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    print('++++++++$obscureText');
    return TextFormField(
      keyboardType: inputType,
      textAlign: TextAlign.center,
      decoration: inputDecoration.copyWith(hintText: hintText, prefixIcon: prefixIcon, suffixIcon: suffixIcon),
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
    );
  }
}