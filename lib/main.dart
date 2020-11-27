import 'package:flutter/material.dart';
import 'package:minimarket/pages/login_page.dart';
import 'package:minimarket/pages/productos_page.dart';
import 'package:minimarket/pages/ventas_page.dart';
import 'package:minimarket/util/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: themeDataApp,
      initialRoute: "/login",
      routes: {
        "/login": (BuildContext context) => LoginScreen(),
        "/productos": (BuildContext context) => ProductosPage(),
        "/ventas": (BuildContext context) => VentasPage()
      },
    );
  }
}
