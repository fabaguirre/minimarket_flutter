import 'package:minimarket/model/entities/producto.dart';

class Venta {
  final int id;
  DateTime fecha;
  double total;
  List<LineaVenta> lineasVenta;

  Venta({this.id, this.fecha, this.total, this.lineasVenta});

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      id: json['id'] as int,
      fecha: DateTime.parse(json['fecha']),
      total: json['total'] as double,
      lineasVenta: LineaVenta.getLineasVentaFromJson(json['lineasVenta']),
    );
  }

  @override
  String toString() {
    return "ID: $id, Fecha: $fecha, Total: $total, Lineas Venta: $lineasVenta";
  }
}

class LineaVenta {
  final int id;
  Producto producto;
  int cantidad;
  double total;

  LineaVenta({this.id, this.producto, this.cantidad, this.total});

  factory LineaVenta.fromJson(Map<String, dynamic> json) {
    return LineaVenta(
      id: json['id'] as int,
      producto: Producto.fromJson(json['producto']),
    );
  }

  static List<LineaVenta> getLineasVentaFromJson(List<dynamic> json) {
    List<LineaVenta> lineasVenta = List<LineaVenta>();
    for (var item in json) {
      lineasVenta.add(LineaVenta.fromJson(item));
    }
    return lineasVenta;
  }
}
