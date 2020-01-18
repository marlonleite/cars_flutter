import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/cars_listview.dart';
import 'package:carros/pages/favorites/favorites_bloc.dart';
import 'package:carros/widget/text_error.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin<FavoritesPage> {

  final _bloc = FavoritesBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Car> cars = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarsListView(cars),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch();
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
