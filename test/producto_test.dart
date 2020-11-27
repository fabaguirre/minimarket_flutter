import 'package:flutter_test/flutter_test.dart';
import 'package:minimarket/model/entities/producto.dart';

main() {
  group('Test Producto', () {
    test('Test 1', () {
      Map<String, dynamic> json = {
        'id': 1,
        'nombre': 'Coca-Cola 1L',
        'precioUnitario': 3.5,
        'unidad': 'Botella',
        'image': 'coca-cola-1l.png',
        'stock': 62
      };
      Producto productoActual = Producto.fromJson(json);

      Producto productoExpected = Producto(
          id: 1,
          nombre: 'Coca-Cola 1L',
          precioUnitario: 3.5,
          unidad: 'Botella',
          image: 'coca-cola-1l.png',
          stock: 62);

      expect(productoActual, productoExpected);
    });
    test('Test 2', () {
      Map<String, dynamic> json = {
        'id': 2,
        'nombre': 'Fanta 500ml',
        'precioUnitario': 2.5,
        'unidad': 'Botella',
        'image': 'fanta-500ml.png',
        'stock': 32
      };
      Producto productoActual = Producto.fromJson(json);

      Producto productoExpected = Producto(
          id: 2,
          nombre: 'Fanta 500ml',
          precioUnitario: 2.5,
          unidad: 'Botella',
          image: 'fanta-500ml.png',
          stock: 32);

      expect(productoActual, productoExpected);
    });
    test('Test 3', () {
      Map<String, dynamic> json = {
        'id': 3,
        'nombre': 'Doritos 60gr',
        'precioUnitario': 1.0,
        'unidad': 'Paquete',
        'image': 'doritos-60gr.png',
        'stock': 30
      };
      Producto productoActual = Producto.fromJson(json);

      Producto productoExpected = Producto(
          id: 3,
          nombre: 'Doritos 60gr',
          precioUnitario: 1.0,
          unidad: 'Paquete',
          image: 'doritos-60gr.png',
          stock: 30);

      expect(productoActual, productoExpected);
    });
    test('Test 4', () {
      Map<String, dynamic> json = {
        'id': 4,
        'nombre': 'Arroz',
        'precioUnitario': 2.4,
        'unidad': 'Kilo',
        'image': 'arroz.png',
        'stock': 11
      };
      Producto productoActual = Producto.fromJson(json);

      Producto productoExpected = Producto(
          id: 4,
          nombre: 'Arroz',
          precioUnitario: 2.4,
          unidad: 'Kilo',
          image: 'arroz.png',
          stock: 11);

      expect(productoActual, productoExpected);
    });
    test('Test 5', () {
      Map<String, dynamic> json = {
        'id': 5,
        'nombre': 'Oreo 26gr',
        'precioUnitario': 0.8,
        'unidad': 'Paquete',
        'image': 'oreo-26gr.png',
        'stock': 36
      };
      Producto productoActual = Producto.fromJson(json);

      Producto productoExpected = Producto(
          id: 5,
          nombre: 'Oreo 26gr',
          precioUnitario: 0.8,
          unidad: 'Paquete',
          image: 'oreo-26gr.png',
          stock: 36);

      expect(productoActual, productoExpected);
    });
  });
}
