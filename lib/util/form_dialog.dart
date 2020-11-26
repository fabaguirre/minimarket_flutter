import 'package:flutter/material.dart';
import 'package:minimarket/model/entities/producto.dart';
import 'package:http/http.dart' as http;

showFormDialog(BuildContext context,
    {String title,
    List<Map<String, dynamic>> fields,
    String textOK,
    String textCancel,
    VoidCallback actionOK,
    VoidCallback actionCancel,
    String token,
    Producto producto}) {
  List<TextEditingController> controllers = getControllers(fields);
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: textCancel != null ? Text(textCancel) : Text('Cancel'),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (actionCancel != null) {
        actionCancel();
      }
    },
  );

  Widget okButton = FlatButton(
    child: textOK != null ? Text(textOK) : Text('OK'),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (producto == null) {
        _createProducto(controllers, token);
      } else {
        _editProducto(controllers, token, producto);
      }

      if (actionOK != null) {
        actionOK();
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: title != null ? Text(title) : Text('Form'),
    content: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          children: fields != null
              ? getTextsField(fields, controllers)
              : <Widget>[TextField()],
        ),
      ),
    ),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  //load fields of producto
  if (producto != null) {
    controllers[0].text = producto.nombre;
    controllers[1].text = producto.precioUnitario.toString();
    controllers[2].text = producto.unidad;
    controllers[3].text = producto.stock.toString();
  }
}

List<Widget> getTextsField(List<Map<String, dynamic>> fields,
    List<TextEditingController> controllers) {
  List<Widget> _fields = [];
  for (var i = 0; i < fields.length; i++) {
    _fields.add(TextField(
      controller: controllers[i],
      keyboardType: fields[i]['type'],
      decoration: InputDecoration(
        hintText: fields[i]['hint'],
      ),
    ));
  }

  return _fields;
}

List<TextEditingController> getControllers(List<Map<String, dynamic>> fields) {
  List<TextEditingController> controllers = [];
  for (var i = 0; i < fields.length; i++) {
    controllers.add(TextEditingController());
  }
  return controllers;
}

_createProducto(List<TextEditingController> controllers, String token) {
  print(controllers[0].text);
  Producto producto = new Producto(
      nombre: controllers[0].text,
      precioUnitario: double.parse(controllers[1].text),
      unidad: controllers[2].text,
      stock: int.parse(controllers[3].text));

  print(producto.toString());

  createProducto(http.Client(), token, producto);
}

_editProducto(
    List<TextEditingController> controllers, String token, Producto producto) {
  producto.nombre = controllers[0].text;
  producto.precioUnitario = double.parse(controllers[1].text);
  producto.unidad = controllers[2].text;
  producto.stock = int.parse(controllers[3].text);

  print(producto.toString());

  editProducto(http.Client(), token, producto);
}
