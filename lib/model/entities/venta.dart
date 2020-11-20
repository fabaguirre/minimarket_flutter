import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:minimarket/model/entities/producto.dart';
import 'package:minimarket/utilities/base_url.dart';

class Venta {
  final int id;
  DateTime fecha;
  double total;
  List<LineaVenta> lineasVenta;

  Venta({this.id, this.fecha, this.total, this.lineasVenta});

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      id: json['id'] as int,
      fecha: DateTime.parse(json['fecha']),
      total: json['total'] as double,
      lineasVenta: LineaVenta.getLineasVentaFromJson(json['lineasVenta']),
    );
  }

  @override
  String toString() {
    return "ID: $id, Fecha: $fecha, Total: $total, Lineas Venta: $lineasVenta";
  }
}

class LineaVenta {
  final int id;
  Producto producto;
  int cantidad;
  double total;

  LineaVenta({this.id, this.producto, this.cantidad, this.total});

  factory LineaVenta.fromJson(Map<String, dynamic> json) {
    return LineaVenta(
      id: json['id'] as int,
      producto: Producto.fromJson(json['producto']),
    );
  }

  static List<LineaVenta> getLineasVentaFromJson(List<dynamic> json) {
    List<LineaVenta> lineasVenta = List<LineaVenta>();
    for (var item in json) {
      lineasVenta.add(LineaVenta.fromJson(item));
    }
    return lineasVenta;
  }
}

List<Venta> parseVentas(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Venta>((json) => Venta.fromJson(json)).toList();
}

Future<List<Venta>> fetchVentas(http.Client client, String token) async {
  final response = await client.get(baseUrl + 'api/ventas/', headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  return parseVentas(response.body);
}
