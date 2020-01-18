import 'package:carros/utils/sql/entity.dart';

class Car extends Entity {
  int id;
  String name;
  String type;
  String description;
  String urlPhoto;
  String urlVideo;
  String latitude;
  String longitude;

  Car({
    this.id,
    this.name,
    this.type,
    this.description,
    this.urlPhoto,
    this.urlVideo,
    this.latitude,
    this.longitude,
  });

  Car.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['nome'];
    type = map['tipo'];
    description = map['descricao'];
    urlPhoto = map['urlFoto'];
    urlVideo = map['urlVideo'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['description'] = this.description;
    data['urlPhoto'] = this.urlPhoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
