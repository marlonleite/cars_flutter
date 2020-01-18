import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;
  Color colorText;
  Color colorLabel;
  bool noBorder;

  AppText(
    this.label,
    this.hint, {
    this.password = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
    this.colorText = Colors.blue,
    this.colorLabel = Colors.grey,
    this.noBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 25,
        color: colorText,
      ),
      decoration: InputDecoration(
          border: noBorder ? InputBorder.none : OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 25,
            color: colorLabel,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16,
          )),
    );
  }
}
