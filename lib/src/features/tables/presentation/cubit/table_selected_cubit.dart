import 'package:diyo_test/src/features/tables/domain/entities/diyo_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableSelectedCubit extends Cubit<DiyoTable?> {
  TableSelectedCubit() : super(null);

  addTable(DiyoTable table) {
    emit(table);
  }

  clear() {
    emit(null);
  }
}
