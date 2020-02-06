
import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/user.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String username, String password) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v1/login';

      Map<String,String> headers = {
        "Content-Type": "application/json"
      };

      Map params = {
        "username": username,
        "password": password
      };

      String s = json.encode(params);
      print(url);
      print(">> $s");

      var response = await http.post(url, body: s, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if(response.statusCode == 200) {
        final user = User.fromJson(mapResponse);

        user.save();

        return ApiResponse.ok(result: user);
      }

      return ApiResponse.error(msg:mapResponse["error"]);
    } catch(error, exception) {
      print("Erro no login $error > $exception");

      return ApiResponse.error(msg:"Não foi possível fazer o login.");
    }
  }
}
