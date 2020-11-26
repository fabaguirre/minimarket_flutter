import 'package:minimarket/model/entities/login_usuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minimarket/util/base_url.dart';

Future<LoginUsuario> postLogin(
    http.Client client, LoginUsuario loginUsuario) async {
  final http.Response response = await client.post(baseUrl + 'auth/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'nombreUsuario': loginUsuario.username,
        'password': loginUsuario.password
      }));

  final parsed = jsonDecode(response.body).cast<String, dynamic>();

  loginUsuario = LoginUsuario.fromJson(parsed);

  return loginUsuario;
}
