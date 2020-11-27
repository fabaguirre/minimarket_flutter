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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Producto &&
          id == other.id &&
          nombre.compareTo(other.nombre) == 0 &&
          precioUnitario == other.precioUnitario &&
          unidad.compareTo(other.unidad) == 0 &&
          image.compareTo(other.image) == 0 &&
          stock == other.stock;

  @override
  int get hashCode =>
      id.hashCode ^
      nombre.hashCode ^
      precioUnitario.hashCode ^
      unidad.hashCode ^
      image.hashCode ^
      stock.hashCode;

  @override
  String toString() {
    return "ID: $id, Nombre: $nombre, Precio Unitario: $precioUnitario, " +
        "Unidad: $unidad, Stock: $stock";
  }
}
