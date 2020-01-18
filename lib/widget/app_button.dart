import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;

  Function onPressed;
  bool showProgress;
  Color color;
  double marginTop;

  AppButton(
    this.text, {
    this.onPressed,
    this.showProgress = false,
    this.color = Colors.blue,
    this.marginTop=0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      margin: EdgeInsets.only(top: marginTop),
      child: RaisedButton(
        color: color,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
        onPressed: onPressed,
      ),
    );
  }
}
