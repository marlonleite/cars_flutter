
import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/car_dao.dart';
import 'package:carros/pages/favorites/favorite-dao.dart';
import 'package:carros/pages/favorites/favorite.dart';
import 'package:carros/pages/favorites/favorites_model.dart';
import 'package:provider/provider.dart';

class FavoriteService {
  static Future<bool> favorite(context, Car c) async {
    Favorite f = Favorite.fromCar(c);

    final dao = FavoriteDAO();

    final exists = await dao.exists(c.id);

    if (exists) {
      dao.delete(c.id);

      Provider.of<FavoritesModel>(context, listen: false).getCars();

      return false;
    } else {
      dao.save(f);

      Provider.of<FavoritesModel>(context, listen: false).getCars();

      return true;
    }
  }

  static Future<List<Car>> getCars() async {
    String sql = "select * from car c,favorite f where c.id=f.id";
    List<Car> cars = await CarDAO().query(sql);
    return cars;
  }

  static Future<bool> isFavorite(Car c) async {
    final dao = FavoriteDAO();

    bool exists = await dao.exists(c.id);

    return exists;
  }
}
