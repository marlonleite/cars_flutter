import 'package:carros/pages/cars/car.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final Car car;

  MapPage(this.car);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;

  Car get car => widget.car;

  @override
  Widget build(BuildContext context) {
    print(car);
    print(car.latlng);

    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: latLng(),
          zoom: 12,
        ),
        onMapCreated: _onMapCreated,
        markers: Set.of(_getMarkers()),
      ),
    );
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
          markerId: MarkerId("1"),
          position: car.latlng,
          infoWindow: InfoWindow(
              title: car.name,
              snippet: "Fábrica ${car.name}",
              onTap: () {
                print("Clicou na janela");
              }),
          onTap: () {
            print("Clicou no marcador");
          })
    ];
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  latLng() {
    return car.latlng;
  }
}
