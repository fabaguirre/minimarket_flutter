import 'package:flutter_test/flutter_test.dart';
import 'package:minimarket/model/entities/venta.dart';

main() {
  group('Tests Venta', () {
    test('Test 1', () {
      Map<String, dynamic> json = {
        'id': 1,
        'fecha': '2020-11-26',
        'total': 54.2,
        'lineasVenta': new List()
      };

      Venta ventaActual = Venta.fromJson(json);

      Venta ventaExpected =
          Venta(id: 1, fecha: new DateTime(2020, 11, 26), total: 54.2);

      expect(ventaActual, ventaExpected);
    });

    test('Test 2', () {
      Map<String, dynamic> json = {
        'id': 2,
        'fecha': '2020-11-26',
        'total': 15.5,
        'lineasVenta': new List()
      };

      Venta ventaActual = Venta.fromJson(json);

      Venta ventaExpected =
          Venta(id: 2, fecha: new DateTime(2020, 11, 26), total: 15.5);

      expect(ventaActual, ventaExpected);
    });

    test('Test 3', () {
      Map<String, dynamic> json = {
        'id': 3,
        'fecha': '2020-11-26',
        'total': 1.5,
        'lineasVenta': new List()
      };

      Venta ventaActual = Venta.fromJson(json);

      Venta ventaExpected =
          Venta(id: 3, fecha: new DateTime(2020, 11, 26), total: 1.5);

      expect(ventaActual, ventaExpected);
    });

    test('Test 4', () {
      Map<String, dynamic> json = {
        'id': 4,
        'fecha': '2020-11-26',
        'total': 80.0,
        'lineasVenta': new List()
      };

      Venta ventaActual = Venta.fromJson(json);

      Venta ventaExpected =
          Venta(id: 4, fecha: new DateTime(2020, 11, 26), total: 80.0);

      expect(ventaActual, ventaExpected);
    });

    test('Test 5', () {
      Map<String, dynamic> json = {
        'id': 5,
        'fecha': '2020-11-26',
        'total': 8.0,
        'lineasVenta': new List()
      };

      Venta ventaActual = Venta.fromJson(json);

      Venta ventaExpected =
          Venta(id: 5, fecha: new DateTime(2020, 11, 26), total: 8.0);

      expect(ventaActual, ventaExpected);
    });
  });
}
