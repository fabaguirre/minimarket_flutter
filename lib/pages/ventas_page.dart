import 'package:flutter/material.dart';
import 'package:minimarket/model/entities/venta.dart';
import 'package:minimarket/model/services/venta_service.dart';
import 'package:minimarket/util/constants.dart';
import 'package:minimarket/util/main_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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
    initializeDateFormatting();
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
                    return _buildVentaRow(venta, index, context);
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

  List<Widget> _getLineasVenta(Venta venta) {
    List<Widget> list = [];
    for (var item in venta.lineasVenta) {
      list.add(Row(
        children: <Widget>[
          Text(item.cantidad.toString()),
          SizedBox(
            width: 10,
          ),
          Text(item.producto.nombre),
          SizedBox(
            width: 10,
          ),
          Text(item.producto.precioUnitario.toString()),
          SizedBox(
            width: 10,
          ),
          Text(item.total.toString()),
        ],
      ));
    }
    return list;
  }

  Widget _buildVentaRow(Venta venta, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: <Widget>[
        Text("${venta.id}",
            style: TextStyle(
              fontSize: 65.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'OpenSans',
              color: Colors.black12,
            )),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(DateFormat.yMMMMd('en_US').format(venta.fecha),
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'OpenSans',
                      color: Colors.black26)),
              SizedBox(
                height: 6,
              ),
              Row(
                children: <Widget>[
                  Text(venta.lineasVenta[0].cantidad.toString()),
                  SizedBox(
                    width: 10,
                  ),
                  Text(venta.lineasVenta[0].producto.nombre),
                  SizedBox(
                    width: 10,
                  ),
                  Text('S/.' +
                      venta.lineasVenta[0].producto.precioUnitario.toString()),
                ],
              ),
              venta.lineasVenta.length < 2
                  ? SizedBox(
                      height: 15,
                    )
                  : Row(
                      children: <Widget>[
                        Text(venta.lineasVenta[1].cantidad.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        Text(venta.lineasVenta[1].producto.nombre),
                        SizedBox(
                          width: 10,
                        ),
                        Text('S/.' +
                            venta.lineasVenta[1].producto.precioUnitario
                                .toString()),
                      ],
                    ),
              venta.lineasVenta.length < 3
                  ? SizedBox(
                      height: 15,
                    )
                  : Center(
                      child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Venta #' + venta.id.toString()),
                                content: SingleChildScrollView(
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      children: _getLineasVenta(venta),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text('Ver más...',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'OpenSans',
                              color: Colors.black38)),
                    )),
            ],
          ),
        ),
        SizedBox(width: 20),
        Text('S/. ',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'OpenSans',
            )),
        Text(venta.total.toString(),
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'OpenSans',
            ))
      ]),
    );
  }
}
