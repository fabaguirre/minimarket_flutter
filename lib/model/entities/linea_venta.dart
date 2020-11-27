import 'package:minimarket/model/entities/producto.dart';

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
        cantidad: json['cantidad'] as int,
        total: json['total'] as double);
  }

  static List<LineaVenta> getLineasVentaFromJson(List<dynamic> json) {
    List<LineaVenta> lineasVenta = List<LineaVenta>();
    for (var item in json) {
      lineasVenta.add(LineaVenta.fromJson(item));
    }
    return lineasVenta;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LineaVenta &&
          id == other.id &&
          producto == other.producto &&
          cantidad == other.cantidad &&
          total == other.total;

  @override
  int get hashCode =>
      id.hashCode ^ producto.hashCode ^ cantidad.hashCode ^ total.hashCode;
}
