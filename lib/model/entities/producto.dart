class Producto {
  final int id;
  String nombre;
  double precioUnitario;
  String unidad;
  String image;
  int stock;

  Producto(
      {this.id,
      this.nombre,
      this.precioUnitario,
      this.unidad,
      this.image,
      this.stock});

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
        id: json['id'] as int,
        nombre: json['nombre'] as String,
        precioUnitario: json['precioUnitario'] as double,
        unidad: json['unidad'] as String,
        image: json['image'] as String,
        stock: json['stock'] as int);
  }

  @override
  String toString() {
    return "ID: $id, Nombre: $nombre, Precio Unitario: $precioUnitario, " +
        "Unidad: $unidad, Stock: $stock";
  }
}
