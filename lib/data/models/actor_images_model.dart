import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/domain/entitites.dart/actor_image_entity.dart';
import 'package:equatable/equatable.dart';

class ActorImagesResponse extends Equatable {
  final int? id;
  final List<ActorImageModel> profiles;

  const ActorImagesResponse({this.id, this.profiles = const []});

  factory ActorImagesResponse.fromMap(Map<String, dynamic> map) {
    return ActorImagesResponse(
      id: map['id'] as int?,
      profiles: List<ActorImageModel>.from(
          (map['profiles'] ?? []).map((e) => ActorImageModel.fromMap(e))),
    );
  }

  List<ActorImageEntity> toEntity() =>
      profiles.map((e) => e.toEntity()).toList();

  @override
  List<Object?> get props => [id, profiles];
}

class ActorImageModel extends Equatable {
  final String? filePath;
  final num? aspectRatio, height, voteAverage, voteCount, width;

  const ActorImageModel(
      {this.filePath,
      this.aspectRatio,
      this.height,
      this.voteAverage,
      this.voteCount,
      this.width});

  factory ActorImageModel.fromMap(Map<String, dynamic> map) {
    return ActorImageModel(
      filePath: map['file_path'] as String?,
      aspectRatio: map['aspect_ratio'] as num?,
      height: map['height'] as num?,
      voteAverage: map['vote_average'] as num?,
      voteCount: map['vote_count'] as num?,
      width: map['width'] as num?,
    );
  }

  ActorImageEntity toEntity() => ActorImageEntity(
        width: width,
        height: height,
        imagePath: filePath != null ? ApiUrls.requestImage(filePath!) : null,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  @override
  List<Object?> get props => [
        aspectRatio,
        height,
        voteAverage,
        filePath,
        voteCount,
        width,
      ];
}
