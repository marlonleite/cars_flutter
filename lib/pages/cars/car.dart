import 'dart:convert' as convert;

import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/sql/entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarEvent extends Event {
  String action; // Save, delete
  String type; // classicos, esportivos, luxo

  CarEvent(this.action, this.type);

  @override
  String toString() {
    return 'CarEvent{action: $action, type: $type}';
  }
}

class Car extends Entity {
  int id;
  String name;
  String type;
  String description;
  String urlPhoto;
  String urlVideo;
  String latitude;
  String longitude;

  get latlng => LatLng(
      latitude == null || latitude.isEmpty ? 0.0 : double.parse(latitude),
      longitude == null || longitude.isEmpty ? 0.0 : double.parse(longitude)
  );

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
    name = map['nome'] ?? map['name'];
    type = map['tipo'] ?? map['type'];
    description = map['descricao'] ?? map['description'];
    urlPhoto = map['urlFoto'] ?? map['urlPhoto'];
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

  Map<String, dynamic> toMapApi() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.name;
    data['tipo'] = this.type;
    data['descricao'] = this.description;
    data['urlFoto'] = this.urlPhoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMapApi());
    return json;
  }

  @override
  String toString() {
    return 'Car{id: $id, name: $name, type: $type, description: $description}';
  }
}
