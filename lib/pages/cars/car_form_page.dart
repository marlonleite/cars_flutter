import 'dart:io';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/cars/car.dart';
import 'package:carros/pages/cars/car_api.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/widget/app_button.dart';
import 'package:carros/widget/app_image.dart';
import 'package:carros/widget/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarFormPage extends StatefulWidget {
  final Car car;

  CarFormPage({this.car});

  @override
  State<StatefulWidget> createState() => _CarFormPageState();
}

class _CarFormPageState extends State<CarFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tName = TextEditingController();
  final tDesc = TextEditingController();
  final tType = TextEditingController();

  Color themeColor = Colors.purple;

  int _radioIndex = 0;

  var _showProgress = false;

  File _file;

  Car get car => widget.car;

  // Add validate email function.
  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do carro.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (car != null) {
      tName.text = car.name;
      tDesc.text = car.description;
      _radioIndex = getTypeInt(car);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          car != null ? car.name : "Novo Carro",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerPhoto(),
          Text(
            "Clique na imagem para selecionar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Tipo",
            style: TextStyle(
              color: themeColor,
              fontSize: 20,
            ),
          ),
          _radioType(),
          Divider(),
          AppText(
            "Nome",
            "",
            controller: tName,
            keyboardType: TextInputType.text,
            validator: _validateName,
            colorText: themeColor,
            noBorder: true,
          ),
          AppText(
            "Descrição",
            "",
            controller: tDesc,
            keyboardType: TextInputType.text,
            validator: _validateName,
            colorText: themeColor,
            noBorder: true,
          ),
          AppButton(
            "Salvar",
            onPressed: _onClickSave,
            showProgress: _showProgress,
            color: themeColor,
            marginTop: 15.0,
          ),
        ],
      ),
    );
  }

  _headerPhoto() {
    return InkWell(
      onTap: _onClickPhoto,
      child: _file != null
          ? Image.file(
              _file,
              height: 150,
            )
          : car != null
              ? AppImage(car.urlPhoto)
              : Image.asset(
                  "assets/images/camera.png",
                  height: 150,
                ),
    );
  }

  _radioType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickType,
          activeColor: themeColor,
        ),
        Text(
          "Clássicos",
          style: TextStyle(color: themeColor, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickType,
          activeColor: themeColor,
        ),
        Text(
          "Esportivos",
          style: TextStyle(color: themeColor, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickType,
          activeColor: themeColor,
        ),
        Text(
          "Luxo",
          style: TextStyle(color: themeColor, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickType(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTypeInt(Car car) {
    switch (car.type) {
      case "classicos":
        return 0;
      case "esportivos":
        return 1;
      default:
        return 2;
    }
  }

  String _getType() {
    switch (_radioIndex) {
      case 0:
        return "classicos";
      case 1:
        return "esportivos";
      default:
        return "luxo";
    }
  }

  void _onClickPhoto() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        this._file = file;
      });
    }
  }

  _onClickSave() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Cria o carro
    var c = car ?? Car();
    c.name = tName.text;
    c.description = tDesc.text;
    c.type = _getType();

    print("Carro: $c");

    setState(() {
      _showProgress = true;
    });

    print("Salvar o carro $c");

    ApiResponse<bool> response = await CarApi.save(c, _file);

    if (response.ok) {
      alert(context, "Carro salvo com sucesso", callback: () {
        EventBus.get(context).sendEvent(CarEvent("Carro Salvo", c.type));

        Navigator.pop(context);
      });
    } else {
      alert(context, response.msg);
    }

    setState(() {
      _showProgress = false;
    });

    print("Fim.");
  }
}
