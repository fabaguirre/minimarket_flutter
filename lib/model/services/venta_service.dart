import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minimarket/util/base_url.dart';
import 'package:minimarket/model/entities/venta.dart';

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
