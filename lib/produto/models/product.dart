import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  // Variveis de instancia
  String? id;
  String? nome;
  String? description;
  String? image;
  double? price;
  int? quantity;
  String? marca;
  // Método construtor
  Product({
    this.id,
    this.nome,
    this.description,
    this.image,
    this.price,
    this.quantity,
    this.marca,
  });

  Product copyWith({
    String? id,
    String? nome,
    String? description,
    String? image,
    double? price,
    int? quantity,
    String? marca,
  }) {
    return Product(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      marca: marca ?? this.marca,
    );
  }

  // Metodo tomap utilizado para enviar dados ao firebase
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'description': description,
      'image': image,
      'price': price,
      'quantity': quantity,
      'marca': marca,
    };
  }

  //Metodos para retornar os dados do firebase
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      marca: map['marca'] != null ? map['marca'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, nome: $nome, description: $description, image: $image, price: $price, quantity: $quantity, marca: $marca)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nome == nome &&
      other.description == description &&
      other.image == image &&
      other.price == price &&
      other.quantity == quantity &&
      other.marca == marca;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nome.hashCode ^
      description.hashCode ^
      image.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      marca.hashCode;
  }
}
