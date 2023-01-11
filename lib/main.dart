import 'package:diyo_test/src/core/database/database_service.dart';
import 'package:diyo_test/src/features/add_to_cart/presentation/cubit/cart_cubit.dart';
import 'package:diyo_test/src/features/checkout/data/datasource/database/check_out_database.dart';
import 'package:diyo_test/src/features/checkout/presentation/bloc/checkout_list_bloc.dart';
import 'package:diyo_test/src/features/product_list/presentation/bloc/product_list_bloc.dart';
import 'package:diyo_test/src/features/product_list/presentation/product_list_screen.dart';
import 'package:diyo_test/src/features/tables/presentation/cubit/table_selected_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/features/service_locator.dart' as sl;

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if (bloc.runtimeType == CartCubit) {
      print(change);
    }
    super.onChange(bloc, change);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.setupServiceLocator();
  await DatabaseService.initDatabase();
  await CheckOutDatabase.createTable();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductListBloc()..add(ProductListLoad())),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => TableSelectedCubit()),
        BlocProvider(
            create: (_) => CheckoutListBloc()..add(CheckoutListLoad())),
      ],
      child: MaterialApp(
          title: 'DIYO',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ProductListScreen()),
    );
  }
}
