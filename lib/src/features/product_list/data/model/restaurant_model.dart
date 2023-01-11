import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';

import 'product_model.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    int? id,
    String? name,
    String? address,
    String? type,
    String? image,
    List<ProductModel>? products,
  }) : super(
          id: id,
          name: name,
          address: address,
          type: type,
          image: image,
          products: products,
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        type: json['type'],
        image: json['image'],
        products: (json['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList(),
      );

  Restaurant toEntities() => Restaurant(
        id: id,
        name: name,
        address: address,
        type: type,
        image: image,
        products: products,
      );
}
