import 'package:bloc_test/bloc_test.dart';
import 'package:diyo_test/src/features/product_list/data/datasource/products.dart';
import 'package:diyo_test/src/features/product_list/domain/repository/product_repository.dart';
import 'package:diyo_test/src/features/product_list/presentation/bloc/product_list_bloc.dart';
import 'package:diyo_test/src/features/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group("ProductListBlocTest tes", () {
    late ProductListBloc bloc;
    setUp(() async {
      await setupServiceLocator();
      bloc = ProductListBloc();
    });

    test("init state ProductListBloc", () {
      expect(bloc.state, isA<ProductListInitial>());
    });

    blocTest("load product",
        build: () => bloc,
        act: ((bloc) => bloc.add(ProductListLoad())),
        expect: () => [isA<ProductListLoading>()]);
  });
}
