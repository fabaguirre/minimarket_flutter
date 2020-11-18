import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minimarket/utilities/base_url.dart';

class Producto {
  final int id;
  final String nombre;
  final double precioUnitario;
  final String unidad;
  final String image;
  final int stock;

  Producto(
      {this.id,
      this.nombre,
      this.precioUnitario,
      this.unidad,
      this.image,
      this.stock});

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        precioUnitario: json['precioUnitario'] as double,
        unidad: json['unidad'] as String,
        image: json['image'] as String,
        stock: json['stock'] as int);
  }

  @override
  String toString() {
    return "ID: $id, Nombre: $nombre, Precio Unitario: $precioUnitario";
  }
}

List<Producto> parseProductos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Producto>((json) => Producto.fromJson(json)).toList();
}

Future<List<Producto>> fetchProductos(http.Client client, String token) async {
  final response = await client.get(baseUrl + 'api/productos/', headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  return parseProductos(response.body);
}

Future<http.Response> deleteProducto(
    http.Client client, String token, int id) async {
  final http.Response response =
      await client.delete(baseUrl + 'api/productos/$id', headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  return response;
}
