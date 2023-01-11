import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String? name;
  final String? type;
  final int? price;
  final String? image;
  const Product({
    this.id,
    this.name,
    this.type,
    this.price,
    this.image,
  });
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        price: json['price'],
        image: json['image'],
      );
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        type,
        price,
        image,
      ];

  static List<String> getTypes(List<Product> products) {
    List<String> result = [];
    products.forEach((product) {
      if (!result.any((type) => type == product.type)) {
        result.add(product.type!);
      }
    });
    return result;
  }
}
