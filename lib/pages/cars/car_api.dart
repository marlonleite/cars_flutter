import 'dart:convert' as convert;

import 'package:carros/pages/cars/car_dao.dart';
import 'package:carros/pages/login/user.dart';

import 'car.dart';

import 'package:http/http.dart' as http;

class CarApiType {
  static final String sportive = "esportivos";
  static final String lux = "luxo";
  static final String classic = "classicos";
}

class CarApi {
  static Future<List<Car>> getCars(String type) async {
    User user = await User.get();

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$type';

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    String body = response.body;

    List list = convert.json.decode(body);

    List<Car> cars = list.map<Car>((map) => Car.fromMap(map)).toList();

    final dao = CarDAO();

    // Salvar todos os carros
    cars.forEach(dao.save);

    return cars;
  }
}
