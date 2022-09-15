import '../../domain/entitites.dart/person_entity.dart';

class PersonModel extends PersonEntity {

  final String birthdayPerson;
  final String knownForDepartment;
  final int personId;
  final String personName;

  final int gender;
  final String biography;
  final double popularity;
  final String placeOfBirth;
  final String profilePath;
  final bool adult;
  final String imdbId;

  const PersonModel({
    this.birthdayPerson = "",
    this.knownForDepartment = "",
    this.personId = 0,
    this.personName = "",
    this.gender = 0,
    this.biography = "",
    this.popularity = 0.0,
    this.placeOfBirth = "",
    this.profilePath = "",
    this.adult = false,
    this.imdbId = "",
  }) : super(
          name: personName,
          id: personId,
          description: biography,
          birthday: birthdayPerson,
        );

  factory PersonModel.fromMap(Map<String, dynamic> json) => PersonModel(
        birthdayPerson: json['birthday'],
        knownForDepartment: json['known_for_department'],
        personId: json['id'],
        personName: json['name'],
        gender: json['gender'],
        biography: json['biography'],
        popularity: json['popularity'],
        profilePath: json['profile_path'],
        adult: json['adult'],
        imdbId: json['imdb_id'],
      );
}