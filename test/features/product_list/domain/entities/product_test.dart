import 'package:diyo_test/src/features/product_list/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Product entities test", () {
    Product? productA;
    Product? productB;

    setUp(() {
      productA = Product();
      productB = Product();
    });
    test("is productA & productB is object of Product", () {
      expect(productA, isA<Product>());
      expect(productB, isA<Product>());
    });
    test("is productA is equals productB", () {
      expect(productA == productB, isTrue);
    });

    test("getTypes function test", () {
      final products = [
        Product(type: "Food"),
        Product(type: "Drink"),
        Product(type: "Food")
      ];

      expect(Product.getTypes(products), isList);
      expect(Product.getTypes(products), equals(<String>["Food", "Drink"]));
    });
  });
}
