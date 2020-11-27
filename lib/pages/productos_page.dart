import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:minimarket/model/entities/producto.dart';
import 'package:minimarket/model/services/producto_service.dart';
import 'package:minimarket/util/confirm_dialog.dart';
import 'package:minimarket/util/constants.dart';
import 'package:minimarket/util/form_dialog.dart';
import 'package:minimarket/util/main_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';

class ProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final String token = arguments['token'] as String;
    return Productos(
      token: token,
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

  @override
  void initState() {
    super.initState();
    _getProductos();
  }

  void _getProductos() {
    Future<List<Producto>> p = fetchProductos(http.Client(), widget.token);
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
    List<Map<String, dynamic>> fields = [
      {'hint': 'Nombre', 'type': TextInputType.text},
      {'hint': 'Precio', 'type': TextInputType.number},
      {'hint': 'Unidad', 'type': TextInputType.text},
      {'hint': 'Stock', 'type': TextInputType.number},
    ];
    showFormDialog(
      context,
      title: 'Editar Producto',
      fields: fields,
      textOK: 'Editar',
      token: widget.token,
      producto: producto,
      actionOK: () {
        setState(() {
          Toast.show("Se guardaron los cambios", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        });
      },
    );
  }

  _showDialogCreateProducto(BuildContext context, String token) {
    List<Map<String, dynamic>> fields = [
      {'hint': 'Nombre', 'type': TextInputType.text},
      {'hint': 'Precio', 'type': TextInputType.number},
      {'hint': 'Unidad', 'type': TextInputType.text},
      {'hint': 'Stock', 'type': TextInputType.number},
    ];
    showFormDialog(
      context,
      title: 'Nuevo Producto',
      fields: fields,
      textOK: 'Guardar',
      token: token,
      actionOK: () {
        Toast.show("Se guardaron el producto", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      },
    );
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

  Widget _buildProductoRow(Producto producto, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: <Widget>[
          producto.image != null
              ? Image.network(
                  producto.image,
                  width: 100,
                )
              : Container(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.image_not_supported,
                    size: 80,
                  ),
                ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              producto.nombre.toUpperCase(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("P.Unit: S/.${producto.precioUnitario}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'OpenSans',
                  )),
              SizedBox(width: 20),
              Text('Stock: ${producto.stock}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'OpenSans',
                  )),
            ],
          ),
        ]),
      ),
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
      body: productos.isEmpty
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
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showDialogCreateProducto(context, widget.token),
      ),
    );
  }
}
