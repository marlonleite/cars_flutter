import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/car_form_page.dart';
import 'package:carros/pages/cars/loripsum.dart';
import 'package:carros/pages/cars/map_page.dart';
import 'package:carros/pages/favorites/favorite_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widget/app_image.dart';
import 'package:carros/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api_response.dart';
import 'car_api.dart';

class CarPage extends StatefulWidget {
  Car car;

  CarPage(this.car);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final _loripsumBloc = LoripsumBloc();

  Color color = Colors.grey;

  Car get car => widget.car;

  @override
  void initState() {
    super.initState();

    FavoriteService.isFavorite(car).then((bool isFavorite) {
      setState(() {
        color = isFavorite ? Colors.red : Colors.grey;
      });
    });

    _loripsumBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMap,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () => _onClickVideo(context),
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "edit",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "delete",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "share",
                  child: Text("Compartilhar"),
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          AppImage(
            car.urlPhoto,
          ),
          _bloc1(),
          Divider(),
          _bloc2(),
        ],
      ),
    );
  }

  Row _bloc1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(car.name, fontSize: 20, bold: true),
            text(car.type, fontSize: 16),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFovorite,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickShare,
            ),
          ],
        ),
      ],
    );
  }

  _bloc2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(car.description, fontSize: 16, bold: true),
        SizedBox(height: 20),
        StreamBuilder<String>(
          stream: _loripsumBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return text(snapshot.data, fontSize: 14);
          },
        ),
      ],
    );
  }

  void _onClickMap() {
    if (car.latitude != null && car.longitude != null) {
      push(context, MapPage(car));
    } else {
      alert(context, "Este carro não possui nenhuma lat/long");
    }
  }

  void _onClickVideo(context) {
    if (car.urlVideo != null && car.urlVideo.isNotEmpty) {
      launch(car.urlVideo);
//      push(context, VideoPage(car));
    } else {
      alert(context, "Este carro não possui nenhum vídeo");
    }
  }

  _onClickPopupMenu(value) {
    switch (value) {
      case "edit":
        push(context, CarFormPage(car: car));
        break;
      case "delete":
        deleteCar();
        break;
      case "share":
        print("Compartilhar");
        break;
    }
  }

  void _onClickFovorite() async {
    bool isFavorite = await FavoriteService.favorite(context, car);

    setState(() {
      color = isFavorite ? Colors.red : Colors.grey;
    });
  }

  void _onClickShare() {}

  void deleteCar() async {
    ApiResponse<bool> response = await CarApi.delete(car);

    if (response.ok) {
      alert(context, "Carro deletado com sucesso", callback: () {
        EventBus.get(context).sendEvent(CarEvent("Carro excluido", car.type));

        Navigator.pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _loripsumBloc.dispose();
  }
}
