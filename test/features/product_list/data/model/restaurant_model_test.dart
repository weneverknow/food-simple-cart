import 'package:diyo_test/src/features/product_list/data/model/restaurant_model.dart';
import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:diyo_test/src/features/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Restaurant Model test", () {
    RestaurantModel? model;
    setUp(() {
      model = RestaurantModel();
    });
    test("is RestaurantModel", () {
      expect(model, isA<RestaurantModel>());
    });
    test("toEntities test", () {
      final rest = model!.toEntities();
      expect(rest, isA<Restaurant>());
      expect(rest.name, isNull);
    });
  });
}
