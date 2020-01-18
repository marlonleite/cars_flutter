
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/user.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/sql/db-helper.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    Future futureDB = DatabaseHelper.getInstance().db;
    Future futureDelay = Future.delayed(Duration(seconds: 3));
    Future<User> futureUser = User.get();

    Future.wait([futureDB, futureDelay, futureUser]).then((List values) {
      User user = values[2];

      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage());
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
