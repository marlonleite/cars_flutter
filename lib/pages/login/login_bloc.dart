import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/cars/simple_bloc.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/user.dart';

class LoginBloc extends SimpleBloc<bool> {

  Future<ApiResponse<User>> login(String username, String password) async {

    add(true);

    ApiResponse response = await LoginApi.login(username, password);

    add(false);

    return response;
  }

}