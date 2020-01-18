import 'dart:convert';

import 'package:carros/api_response.dart';
import 'package:carros/pages/login/user.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String username, String password) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> headers = {"Content-type": "application/json"};

      Map params_auth = {'username': username, 'password': password};

      String params = json.encode(params_auth);

      var response = await http.post(url, body: params, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(mapResponse);

        user.save();

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse['error']);
    } catch (error, exception) {
      print("Erro no login $error > $exception");

      return ApiResponse.error("Não foi possível fazer o login.");
    }
  }
}
