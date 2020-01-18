import 'dart:async';

import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/car_api.dart';
import 'package:carros/pages/cars/simple_bloc.dart';
import 'package:carros/pages/cars/car_dao.dart';
import 'package:carros/utils/network.dart';

class CarsBloc extends SimpleBloc<List<Car>> {
  Future<List<Car>> fetch(String type) async {
    try {
      List<Car> cars;

      if (!await isNetworkOn()) {
        cars = await CarDAO().findAllByType(type);
      } else {
        cars = await CarApi.getCars(type);
      }

      add(cars);

      return cars;
    } catch (e) {
      addError(e);
    }
  }
}
