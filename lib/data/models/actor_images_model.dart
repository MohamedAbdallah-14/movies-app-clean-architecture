import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/domain/entitites.dart/actor_image_entity.dart';

class ActorImagesResponse {
  final String? id;
  final List<ActorImageModel> profiles;

  const ActorImagesResponse({this.id, this.profiles = const []});

  factory ActorImagesResponse.fromMap(Map<String, dynamic> map) {
    return ActorImagesResponse(
      id: map['id'] as String?,
      profiles: List<ActorImageModel>.from(
          (map['profiles'] ?? []).map((e) => ActorImageModel.fromMap(e))),
    );
  }

  List<ActorImageEntity> toEntity() =>
      profiles.map((e) => e.toEntity()).toList();
}

class ActorImageModel {
  final String? file_path;
  final num? aspect_ratio, height, vote_average, vote_count, width;

  const ActorImageModel(
      {this.file_path,
      this.aspect_ratio,
      this.height,
      this.vote_average,
      this.vote_count,
      this.width});

  factory ActorImageModel.fromMap(Map<String, dynamic> map) {
    return ActorImageModel(
      file_path: map['file_path'] as String?,
      aspect_ratio: map['aspect_ratio'] as num?,
      height: map['height'] as num?,
      vote_average: map['vote_average'] as num?,
      vote_count: map['vote_count'] as num?,
      width: map['width'] as num?,
    );
  }

  ActorImageEntity toEntity() => ActorImageEntity(
        width: width,
        height: height,
        imagePath: file_path != null ? ApiUrls.requestImage(file_path!) : null,
        voteAverage: vote_average,
        voteCount: vote_count,
      );
}
