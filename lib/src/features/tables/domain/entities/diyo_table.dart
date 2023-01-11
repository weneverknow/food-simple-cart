import 'package:equatable/equatable.dart';

class DiyoTable extends Equatable {
  final String? id;
  final String? name;
  DiyoTable({this.id, this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
