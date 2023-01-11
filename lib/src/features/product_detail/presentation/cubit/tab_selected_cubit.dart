import 'package:flutter_bloc/flutter_bloc.dart';

class TabSelectedCubit extends Cubit<String> {
  TabSelectedCubit(String initialType) : super(initialType);

  change(String type) {
    emit(type);
  }
}
