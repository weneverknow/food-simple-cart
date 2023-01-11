import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final String? type;
  final String? image;
  final List<Product>? products;

  const Restaurant({
    this.id,
    this.name,
    this.address,
    this.type,
    this.image,
    this.products,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        type: json['type'],
        image: json['image'],
        products:
            (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
      );

  @override
  List<Object?> get props => [id, name, address, type, image];
}
