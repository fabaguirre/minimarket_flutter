import 'package:minimarket/model/entities/linea_venta.dart';

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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Venta &&
          id == other.id &&
          fecha.compareTo(other.fecha) == 0 &&
          total == other.total;

  @override
  int get hashCode => id.hashCode ^ fecha.hashCode ^ total.hashCode;

  @override
  String toString() {
    return "ID: $id, Fecha: $fecha, Total: $total, Lineas Venta: $lineasVenta";
  }
}
