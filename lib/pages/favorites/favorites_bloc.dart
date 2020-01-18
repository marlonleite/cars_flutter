import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/car_api.dart';
import 'package:carros/pages/cars/simple_bloc.dart';
import 'package:carros/pages/cars/car_dao.dart';
import 'package:carros/pages/favorites/favorite_service.dart';
import 'package:carros/utils/network.dart';

class FavoritesBloc extends SimpleBloc<List<Car>> {

  Future<List<Car>> fetch() async {
    try {

      List<Car> cars = await FavoriteService.getCars();

      add(cars);

      return cars;

    } catch (e) {
      addError(e);
    }
  }
}
