import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/domain/entitites.dart/actor_entity.dart';
import 'package:equatable/equatable.dart';

class ActorModel extends Equatable {
  final String? biography,
      birthday,
      deathday,
      imdbId,
      knownForDepartment,
      name,
      placeOfBirth,
      profilePath;
  final num? popularity;
  final num? id;

  const ActorModel(
      {this.biography,
      this.birthday,
      this.deathday,
      this.id,
      this.imdbId,
      this.knownForDepartment,
      this.name,
      this.placeOfBirth,
      this.profilePath,
      this.popularity});

  factory ActorModel.fromMap(Map<String, dynamic> map) {
    return ActorModel(
      biography: map['biography'] as String?,
      birthday: map['birthday'] as String?,
      deathday: map['deathday'] as String?,
      id: map['id'] as int?,
      imdbId: map['imdb_id'] as String?,
      knownForDepartment: map['known_for_department'] as String?,
      name: map['name'] as String?,
      placeOfBirth: map['place_of_birth'] as String?,
      profilePath: map['profile_path'] as String?,
      popularity: map['popularity'] as num?,
    );
  }

  ActorEntity toActorEntity() => ActorEntity(
      id: id?.toString(),
      name: name,
      biography: biography,
      birthday: birthday,
      profilePicture:
          profilePath != null ? ApiUrls.requestImage(profilePath!) : null);

  @override
  List<Object?> get props => [
        biography,
        birthday,
        deathday,
        imdbId,
        knownForDepartment,
        name,
        placeOfBirth,
        profilePath,
        id,
        popularity,
      ];
}
