import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minimarket/model/entities/venta.dart';
import 'package:minimarket/util/confirm_dialog.dart';
import 'package:minimarket/util/constants.dart';
import 'package:minimarket/util/main_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VentasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final String token = arguments['token'] as String;
    return Ventas(
      token: token,
    );
  }
}

class Ventas extends StatefulWidget {
  final String token;

  const Ventas({Key key, this.token}) : super(key: key);
  @override
  _VentasState createState() => _VentasState();
}

class _VentasState extends State<Ventas> {
  List<Venta> ventas = List<Venta>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _getVentas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: titleStyle(),
        ),
      ),
      drawer: MainDrawer(
        context: context,
        token: widget.token,
      ),
      body: ventas.isEmpty
          ? Center(child: Text('No hay ventas para mostrar'))
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: MaterialClassicHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  return Container(
                    height: 55.0,
                    child: Center(child: SizedBox()),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                  itemCount: this.ventas.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Venta venta = this.ventas[index];
                    return _buildVentaRow(venta, index);
                  }),
            ),
    );
  }

  void _getVentas() {
    Future<List<Venta>> v = fetchVentas(http.Client(), widget.token);
    v.then((value) {
      print(value.toString());
      print(value[0].lineasVenta[0].producto.unidad);
      setState(() {
        ventas = value;
      });
    });
  }

  _deleteVenta(Venta venta, int index) {
    print('Eliminar Venta ${venta.id}');
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    try {
      print('Actualizando ventas');
      _getVentas();
      _refreshController.refreshCompleted();
    } catch (e) {
      print('Error Actualizando');
      _refreshController.refreshFailed();
    }
  }

  Widget _buildVentaRow(Venta venta, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Row(children: <Widget>[
        Text("${venta.id}",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'OpenSans',
            )),
        SizedBox(width: 20),
        Container(
          child: Center(
            child: Text(venta.fecha.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'OpenSans',
                )),
          ),
        ),
      ]),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Eliminar',
          color: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          onTap: () => showConfirmDialog(
            context,
            title: '¿Está seguro que desea eliminar este venta?',
            content:
                'La venta con ID:${venta.id} se quitará de la lista de ventas',
            textOK: 'Sí, estoy seguro',
            textCancel: 'Cancelar',
            actionOK: () => _deleteVenta(venta, index),
          ),
        ),
      ],
    );
  }
}
