import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/car_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarsListView extends StatelessWidget {
  List<Car> cars;

  CarsListView(this.cars);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: cars != null ? cars.length : 0,
        itemBuilder: (context, index) {
          Car car = cars[index];
          return Container(
            height: 280,
            child: InkWell(
              onTap: () {
                _onClickCar(context, car);
              },
              onLongPress: () {
                _onLongClickCar(context, car);
              },
              child: Card(
                color: Colors.grey[100],
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: AppImage(
                          car.urlPhoto,
                          width: 250,
                        ),
                      ),
                      Text(
                        car.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "descrição...",
                        style: TextStyle(fontSize: 16),
                      ),
                      ButtonBarTheme(
                        data: ButtonBarThemeData(),
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('DETALHE'),
                              onPressed: () => _onClickCar(context, car),
                            ),
                            FlatButton(
                              child: const Text('COMPARTILHAR'),
                              onPressed: () => _onClickShare(context, car),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCar(context, Car car) {
    push(context, CarPage(car));
  }

  void _onLongClickCar(BuildContext context, Car car) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  car.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text("Detalhe"),
                leading: Icon(Icons.directions_car),
                onTap: () {
                  Navigator.pop(context);
                  _onClickCar(context, car);
                },
              ),
              ListTile(
                title: Text("Compartilhar"),
                leading: Icon(Icons.share),
                onTap: () {
                  Navigator.pop(context);
                  _onClickShare(context, car);
                },
              )
            ],
          );
        });
  }

  void _onClickShare(BuildContext context, Car car) {
    print("Compartilhar ${car.name}");

    Share.share(car.urlPhoto);
  }
}
