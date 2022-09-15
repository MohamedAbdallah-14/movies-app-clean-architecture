import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String birthday;

  const PersonEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.birthday,
  });

  @override
  List<Object?> get props => [id, name, description, birthday];

  @override
  bool? get stringify => true;
}
