import 'package:flutter_test/flutter_test.dart';
import 'package:minimarket/model/entities/linea_venta.dart';
import 'package:minimarket/model/entities/producto.dart';

main() {
  group('Test Linea Venta from JSON', () {
    test('Test 1', () {
      Map<String, dynamic> producto = {
        'id': 1,
        'nombre': 'Coca-Cola 1L',
        'precioUnitario': 3.5,
        'unidad': 'Botella',
        'image': 'coca-cola-1l.png',
        'stock': 62
      };
      Map<String, dynamic> json = {
        'id': 1,
        'producto': producto,
        'cantidad': 5,
        'total': 17.5
      };

      LineaVenta lineaVentaActual = LineaVenta.fromJson(json);

      LineaVenta lineaVentaExpected = LineaVenta(
          id: 1,
          producto: new Producto(
              id: 1,
              nombre: 'Coca-Cola 1L',
              precioUnitario: 3.5,
              unidad: 'Botella',
              image: 'coca-cola-1l.png',
              stock: 62),
          cantidad: 5,
          total: 17.5);

      expect(lineaVentaActual, lineaVentaExpected);
    });

    test('Test 2', () {
      Map<String, dynamic> producto = {
        'id': 2,
        'nombre': 'Fanta 500ml',
        'precioUnitario': 2.5,
        'unidad': 'Botella',
        'image': 'fanta-500ml.png',
        'stock': 32
      };
      Map<String, dynamic> json = {
        'id': 2,
        'producto': producto,
        'cantidad': 3,
        'total': 7.5
      };

      LineaVenta lineaVentaActual = LineaVenta.fromJson(json);

      LineaVenta lineaVentaExpected = LineaVenta(
          id: 2,
          producto: new Producto(
              id: 2,
              nombre: 'Fanta 500ml',
              precioUnitario: 2.5,
              unidad: 'Botella',
              image: 'fanta-500ml.png',
              stock: 32),
          cantidad: 3,
          total: 7.5);

      expect(lineaVentaActual, lineaVentaExpected);
    });
  });
}
