import 'dart:convert' as convert;

import 'package:carros/utils/prefs.dart';

class User {
  String username;
  String name;
  String email;
  String urlPhoto;
  String token;
  List<String> roles;

  User(this.username, this.name, this.email, this.urlPhoto, this.token,
      this.roles);

  User.fromJson(Map<String, dynamic> json) {
    username = json['login'];
    name = json['nome'];
    email = json['email'];
    urlPhoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.username;
    data['nome'] = this.name;
    data['email'] = this.email;
    data['urlFoto'] = this.urlPhoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }

  static Future<User> get() async {
    String json = await Prefs.getString("user.prefs");
    if (json.isEmpty) {
      return null;
    }
    Map map = convert.json.decode(json);
    User user = User.fromJson(map);
    return user;
  }

  @override
  String toString() {
    return 'User{username: $username, name: $name}';
  }


}
