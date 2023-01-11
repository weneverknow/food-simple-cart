import 'package:diyo_test/src/features/product_list/domain/entities/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Restaurant entities test", () {
    Restaurant? restA;
    Restaurant? restB;
    setUp(() {
      restA = Restaurant();
      restB = Restaurant();
    });
    test("is restA & restB is object of Restaurant", () {
      expect(restA, isA<Restaurant>());
      expect(restB, isA<Restaurant>());
    });
    test("equatable test", () {
      expect(restA == restB, isTrue);
    });
  });
}
