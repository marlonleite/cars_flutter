import 'package:carros/pages/favorites/favorite.dart';
import 'package:carros/utils/sql/base-dao.dart';

// Data Access Object
class FavoriteDAO extends BaseDAO<Favorite> {

  @override
  Favorite fromMap(Map<String, dynamic> map) {
    return Favorite.fromMap(map);
  }

  @override
  String get tableName => "favorite";
}
