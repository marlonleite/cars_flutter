import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/cars_bloc.dart';
import 'package:carros/pages/cars/cars_listview.dart';
import 'package:carros/widget/text_error.dart';
import 'package:flutter/material.dart';

class CarsPage extends StatefulWidget {
  String type;

  CarsPage(this.type);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage>
    with AutomaticKeepAliveClientMixin<CarsPage> {
  List<Car> cars;

  String get type => widget.type;

  final _bloc = CarsBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(type);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("CarsListView build ${type}");

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
    return _bloc.fetch(type);
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }


}
