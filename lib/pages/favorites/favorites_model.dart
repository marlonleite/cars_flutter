import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/favorites/favorite_service.dart';
import 'package:flutter/material.dart';

class FavoritesModel extends ChangeNotifier {
  List<Car> cars = [];

  Future<List<Car>> getCars() async {
    cars = await FavoriteService.getCars();

    notifyListeners();

    return cars;
  }


}
