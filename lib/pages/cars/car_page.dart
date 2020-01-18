import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/loripsum.dart';
import 'package:carros/pages/favorites/favorite_service.dart';
import 'package:carros/widget/text.dart';
import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  Car car;

  CarPage(this.car);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final _loripsumBloc = LoripsumBloc();

  Car get car => widget.car;

  @override
  void initState() {
    super.initState();

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
            onPressed: _onClickVideo,
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
          CachedNetworkImage(imageUrl: car.urlPhoto),
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
                color: Colors.red,
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

  void _onClickMap() {}

  void _onClickVideo() {}

  _onClickPopupMenu(value) {
    switch (value) {
      case "edit":
        print("Editar");
        break;
      case "delete":
        print("Apagar");
        break;
      case "share":
        print("Compartilhar");
        break;
    }
  }

  void _onClickFovorite() async {
    FavoriteService.favorite(car);
  }

  void _onClickShare() {}

  @override
  void dispose() {
    super.dispose();

    _loripsumBloc.dispose();
  }
}
