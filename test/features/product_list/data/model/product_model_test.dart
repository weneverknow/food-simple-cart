import 'package:diyo_test/src/features/product_list/data/model/product_model.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Product Model test", () {
    ProductModel? model;
    setUp(() {
      model = ProductModel(
          id: 1, name: "Fried Rice", type: "Food", price: 10, image: "");
    });

    test("is ProductModel", () {
      expect(model, isA<ProductModel>());
    });
    test("toEntities test", () {
      final product = model!.toEntities();
      expect(product, isA<Product>());
      expect(product.name, equals("Fried Rice"));
    });
  });
}
