import 'package:carros/pages/cars/car.dart';
import 'package:carros/utils/sql/base-dao.dart';

// Data Access Object
class CarDAO extends BaseDAO<Car> {
  @override
  String get tableName => "car";

  @override
  Car fromMap(Map<String, dynamic> map) {
    return Car.fromMap(map);
  }

  Future<List<Car>> findAllByType(String type) {

    return query('select * from $tableName where type =? ', [type]);

  }
}
