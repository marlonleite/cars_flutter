import 'package:carros/pages/cars/car.dart';
import 'package:carros/utils/sql/entity.dart';

class Favorite extends Entity {
  int id;
  String name;

  Favorite.fromCar(Car c) {
    id = c.id;
    name = c.name;
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
