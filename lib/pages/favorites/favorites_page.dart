import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/cars_listview.dart';
import 'package:carros/pages/favorites/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin<FavoritesPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    FavoritesModel model = Provider.of<FavoritesModel>(context, listen: false);
    model.getCars();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritesModel model = Provider.of<FavoritesModel>(context);

    List<Car> cars = model.cars;

    if (cars.isEmpty) {
      return Center(
        child: Text(
          "Nenhum carro nos favoritos",
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarsListView(cars),
    );
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritesModel>(context, listen: false).getCars();
  }
}
