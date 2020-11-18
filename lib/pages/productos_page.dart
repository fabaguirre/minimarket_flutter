import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:minimarket/model/entities/producto.dart';
import 'package:minimarket/utilities/confirm_dialog.dart';
import 'package:minimarket/utilities/constants.dart';
import 'package:minimarket/utilities/main_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() => runApp(ProductosPage());

class ProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String token = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Material App',
      theme: themeDataApp,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            appName,
            style: titleStyle(),
          ),
        ),
        drawer: MainDrawer(
          context: context,
        ),
        body: Productos(
          token: token,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => print('Crear nuevo producto'),
        ),
      ),
    );
  }
}

class Productos extends StatefulWidget {
  Productos({Key key, this.token}) : super(key: key);
  final String token;

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Producto> productos = List<Producto>();

  void _getProductos() {
    Future<List<Producto>> p = fetchProductos(http.Client(), widget.token);
    //p.then((value) => productos = value);
    p.then((value) {
      setState(() {
        productos = value;
      });
    });
  }

  void _deleteProducto(Producto producto, int index) {
    deleteProducto(http.Client(), widget.token, producto.id);
    setState(() {
      productos.removeAt(index);
    });
  }

  void _editProducto(Producto producto) {
    print('Editar ' + producto.nombre);
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    try {
      print('Actualizando productos');
      _getProductos();
      _refreshController.refreshCompleted();
    } catch (e) {
      print('Error Actualizando');
      _refreshController.refreshFailed();
    }
  }

  @override
  void initState() {
    super.initState();
    _getProductos();
  }

  @override
  Widget build(BuildContext context) {
    return productos.isEmpty
        ? Center(child: Text('No hay productos para mostrar'))
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
                itemCount: this.productos.length,
                itemBuilder: (BuildContext context, int index) {
                  final Producto producto = this.productos[index];
                  return _buildProductoRow(producto, index);
                }),
          );
  }

  Widget _buildProductoRow(Producto producto, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Row(children: <Widget>[
        Image.network(
          producto.image,
          width: 100,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Text(
            producto.nombre,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(width: 20),
        Text("S/." + producto.precioUnitario.toString(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'OpenSans',
            )),
        SizedBox(width: 20),
        Container(
          child: Center(
            child: Text(producto.stock.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'OpenSans',
                )),
          ),
          width: 50,
        ),
      ]),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Editar',
          color: Colors.orange[400],
          foregroundColor: Colors.white,
          icon: Icons.edit,
          onTap: () => _editProducto(producto),
        ),
        IconSlideAction(
          caption: 'Eliminar',
          color: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          onTap: () => showConfirmDialog(
            context,
            title: '¿Está seguro que desea eliminar este producto?',
            content: '${producto.nombre} se quitará de la lista de productos',
            textOK: 'Sí, estoy seguro',
            textCancel: 'Cancelar',
            actionOK: () => _deleteProducto(producto, index),
          ),
        ),
      ],
    );
  }
}
