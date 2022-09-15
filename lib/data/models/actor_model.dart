import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/domain/entitites.dart/actor_entity.dart';

class ActorModel {
  final String? biography,
      birthday,
      deathday,
      id,
      imdb_id,
      known_for_department,
      name,
      place_of_birth,
      profile_path;
  final int? popularity;

  const ActorModel(
      {this.biography,
      this.birthday,
      this.deathday,
      this.id,
      this.imdb_id,
      this.known_for_department,
      this.name,
      this.place_of_birth,
      this.profile_path,
      this.popularity});

  factory ActorModel.fromMap(Map<String, dynamic> map) {
    return ActorModel(
      biography: map['biography'] as String?,
      birthday: map['birthday'] as String?,
      deathday: map['deathday'] as String?,
      id: map['id'] as String?,
      imdb_id: map['imdb_id'] as String?,
      known_for_department: map['known_for_department'] as String?,
      name: map['name'] as String?,
      place_of_birth: map['place_of_birth'] as String?,
      profile_path: map['profile_path'] as String?,
      popularity: map['popularity'] as int?,
    );
  }

  ActorEntity toActorEntity() => ActorEntity(
      id: id,
      name: name,
      biography: biography,
      birthday: birthday,
      profilePicture:
          profile_path != null ? ApiUrls.requestImage(profile_path!) : null);
}
