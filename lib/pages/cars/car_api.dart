import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/cars/upload_api.dart';
import 'package:carros/utils/http_helper.dart' as http;

import 'car.dart';

class CarApiType {
  static final String sportive = "esportivos";
  static final String lux = "luxo";
  static final String classic = "classicos";
}

class CarApi {
  static Future<List<Car>> getCars(String type) async {

    var url =
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$type';

    print("GET > $url");

    var response = await http.get(url);

    String body = response.body;

    List list = convert.json.decode(body);

    List<Car> cars = list.map<Car>((map) => Car.fromMap(map)).toList();

    return cars;
  }

  static Future<ApiResponse<bool>> save(Car c, File file) async {
    try {

      if (file != null) {
        ApiResponse<String> response = await UploadApi.upload(file);
        if (response.ok){
          String urlPhoto = response.result;
          c.urlPhoto = urlPhoto;
        }
      }

      var url = 'https://carros-springboot.herokuapp.com/api/v1/carros';
      if (c.id != null) {
        url += "/${c.id}";
      }

      print("POST > $url");

      String json = c.toJson();

      print("   JSON > $json");

      var response = await (c.id == null
          ? http.post(url, body: json)
          : http.put(url, body: json));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = convert.json.decode(response.body);

        Car car = Car.fromMap(mapResponse);

        print("Novo carro: ${car.id}");

        return ApiResponse.ok();
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error(msg: "Não foi possível salvar o carro");
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(msg:mapResponse["error"]);
    } catch (e) {
      print(e);

      return ApiResponse.error(msg:"Não foi possível salvar o carro");
    }
  }

  static Future<ApiResponse<bool>> delete(Car c) async {
    try {

      var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/${c.id}';

      print("DELETE > $url");

      var response = await http.delete(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResponse.ok();
      }

      return ApiResponse.error(msg:"Não foi possível deletar o carro");
    } catch (e) {
      print(e);

      return ApiResponse.error(msg:"Não foi possível deletar o carro");
    }
  }
}
