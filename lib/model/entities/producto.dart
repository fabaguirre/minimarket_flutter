import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minimarket/util/base_url.dart';

class Producto {
  final int id;
  String nombre;
  double precioUnitario;
  String unidad;
  String image;
  int stock;

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
    return "ID: $id, Nombre: $nombre, Precio Unitario: $precioUnitario, " +
        "Unidad: $unidad, Stock: $stock";
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

Future<http.Response> createProducto(
    http.Client client, String token, Producto producto) async {
  final http.Response response = await client.post(baseUrl + 'api/productos',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'nombre': producto.nombre,
        'precioUnitario': producto.precioUnitario.toString(),
        'unidad': producto.unidad,
        'stock': producto.stock.toString(),
      }));
  return response;
}

Future<http.Response> editProducto(
    http.Client client, String token, Producto producto) async {
  final http.Response response =
      await client.put(baseUrl + 'api/productos/${producto.id}',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(<String, String>{
            'nombre': producto.nombre,
            'precioUnitario': producto.precioUnitario.toString(),
            'unidad': producto.unidad,
            'stock': producto.stock.toString(),
          }));
  return response;
}
