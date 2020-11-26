import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:minimarket/util/base_url.dart';

class LoginUsuario {
  final String username;
  final String password;
  final String token;

  LoginUsuario(this.username, this.password, {this.token});

  factory LoginUsuario.fromJson(Map<String, dynamic> json) {
    return LoginUsuario(json['nombreUsuario'] as String, 'password',
        token: json['token'] as String);
  }
}

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
