import 'package:flutter_test/flutter_test.dart';
import 'package:minimarket/model/entities/login_usuario.dart';

main() {
  group('Test Login Usuario', () {
    test('Test 1', () {
      Map<String, dynamic> json = {
        'nombreUsuario': 'admin',
        'password': 'password',
        'token': 'token'
      };

      LoginUsuario loginUsuarioActual = LoginUsuario.fromJson(json);
      LoginUsuario loginUsuarioExpected =
          LoginUsuario('admin', 'password', token: 'token');

      expect(loginUsuarioActual, loginUsuarioExpected);
    });

    test('Test 2', () {
      Map<String, dynamic> json = {
        'nombreUsuario': 'fab',
        'password': 'password',
        'token': 'token2'
      };

      LoginUsuario loginUsuarioActual = LoginUsuario.fromJson(json);
      LoginUsuario loginUsuarioExpected =
          LoginUsuario('fab', 'password', token: 'token2');

      expect(loginUsuarioActual, loginUsuarioExpected);
    });

    test('Test 3', () {
      Map<String, dynamic> json = {
        'nombreUsuario': 'user',
        'password': 'password',
        'token': 'token3'
      };

      LoginUsuario loginUsuarioActual = LoginUsuario.fromJson(json);
      LoginUsuario loginUsuarioExpected =
          LoginUsuario('user', 'password', token: 'token3');

      expect(loginUsuarioActual, loginUsuarioExpected);
    });
  });
}
