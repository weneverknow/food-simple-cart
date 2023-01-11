import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    int? id,
    String? name,
    String? type,
    int? price,
    String? image,
  }) : super(id: id, name: name, type: type, price: price, image: image);

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        price: json['price'],
        image: json['image'],
      );

  Product toEntities() => Product(
        id: id,
        name: name,
        type: type,
        price: price,
        image: image,
      );
}
