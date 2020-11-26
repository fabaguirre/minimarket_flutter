import 'package:flutter/material.dart';
import 'package:minimarket/util/confirm_dialog.dart';
import 'package:minimarket/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  final BuildContext context;
  final String token;
  const MainDrawer({Key key, this.context, this.token}) : super(key: key);
  Widget _buildActionTitle(
      String nameAction, IconData iconAction, Function function) {
    return ListTile(
      leading: Icon(
        iconAction,
      ),
      title: Text(
        nameAction,
        style: kActionMenuStyle,
      ),
      onTap: function,
    );
  }

  void _logout() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    deletePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.store,
                      size: 70,
                      color: Colors.white,
                    ),
                    Text(
                      appName,
                      style: titleStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
            _buildActionTitle('Productos', Icons.article, () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed('/productos', arguments: {'token': token});
            }),
            _buildActionTitle('Ventas', Icons.shopping_cart, () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed('/ventas', arguments: {'token': token});
            }),
            _buildActionTitle('Salir', Icons.exit_to_app, () {
              showConfirmDialog(
                this.context,
                title: '¿Está seguro de que desea cerrar sesión?',
                content: 'Se cerrará sesión en este dispositivo',
                textOK: 'Sí, estoy seguro',
                textCancel: 'Cancelar',
                actionOK: () => _logout(),
              );
            }),
          ],
        ),
      ),
    );
  }

  void deletePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
