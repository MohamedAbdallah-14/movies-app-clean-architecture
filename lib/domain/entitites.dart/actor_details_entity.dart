import 'package:equatable/equatable.dart';

class ActorDetailsEntity extends Equatable {
  final String biography;
  final String birthday;
  final String place_of_birth;
  final int gender;

  const ActorDetailsEntity(this.biography, this.birthday, this.place_of_birth, this.gender);

  @override
  List<Object> get props => [biography, birthday, place_of_birth, gender];
}
