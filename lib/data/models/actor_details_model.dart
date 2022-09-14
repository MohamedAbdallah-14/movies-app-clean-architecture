import 'package:app_example/domain/entitites.dart/actor_details_entity.dart';

class ActorDetailsModel extends ActorDetailsEntity {
  const ActorDetailsModel({required this.biography, required this.birthday, required this.place_of_birth, required this.gender})
      : super(
          '',
          '',
          '',
          2,
        );
  final String biography;
  final String birthday;
  final String place_of_birth;
  final int gender;

  factory ActorDetailsModel.fromMap(Map<String, dynamic> json) => ActorDetailsModel(
        biography: json['biography'] ?? '',
        birthday: json['birthday'] ?? '',
        gender: json['gender'] ?? 2,
        place_of_birth: json['place_of_birth'] ?? '',
      );
}
