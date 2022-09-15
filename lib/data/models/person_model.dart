import 'package:app_example/domain/entitites.dart/person_entity.dart';

class PersonModel extends PersonEntity {
  final String birthday;
  final String knownForDepartment;
  final int id;
  final String name;

  final int gender;
  final String biography;
  final double popularity;
  final String placeOfBirth;
  final String profilePath;
  final bool adult;
  final String imdbId;

  const PersonModel({
    this.birthday = "",
    this.knownForDepartment = "",
    this.id = 0,
    this.name = "",
    this.gender = 0,
    this.biography = "",
    this.popularity = 0.0,
    this.placeOfBirth = "",
    this.profilePath = "",
    this.adult = false,
    this.imdbId = "",
  }) : super(
          name: name,
          id: id,
          description: biography,
          birthday: birthday,
        );

  factory PersonModel.fromMap(Map<String, dynamic> json) => PersonModel(
        birthday: json['birthday'],
        knownForDepartment: json['known_for_department'],
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        biography: json['biography'],
        popularity: json['popularity'],
        profilePath: json['profile_path'],
        adult: json['adult'],
        imdbId: json['imdb_id'],
      );
}
