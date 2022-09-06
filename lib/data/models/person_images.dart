import 'package:app_example/data/models/safe_convert.dart';
import 'package:app_example/domain/entitites.dart/person_images_entity.dart';

class PersonImages extends PersonImagesEntity {
  // 66633
  final int id;
  final List<ProfilesItem> profiles;

  PersonImages({
    this.id = 0,
    required this.profiles,
  }) : super(images: profiles.map((e) => e.filePath).toList());

  factory PersonImages.fromJson(Map<String, dynamic>? json) => PersonImages(
        id: asInt(json, 'id'),
        profiles: asList(json, 'profiles')
            .map((e) => ProfilesItem.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'profiles': profiles.map((e) => e.toJson()).toList(),
      };
}

class ProfilesItem {
  // 0.666666666666667
  final double aspectRatio;
  // /lYqC8Amj4owX05xQg5Yo7uUHgah.jpg
  final String filePath;
  // 3000
  final int height;
  // 5.3125
  final double voteAverage;
  // 0
  final int voteCount;
  // 2000
  final int width;

  ProfilesItem({
    this.aspectRatio = 0.0,
    this.filePath = "",
    this.height = 0,
    this.voteAverage = 0.0,
    this.voteCount = 0,
    this.width = 0,
  });

  factory ProfilesItem.fromJson(Map<String, dynamic>? json) => ProfilesItem(
        aspectRatio: asDouble(json, 'aspect_ratio'),
        filePath: asString(json, 'file_path'),
        height: asInt(json, 'height'),
        voteAverage: asDouble(json, 'vote_average'),
        voteCount: asInt(json, 'vote_count'),
        width: asInt(json, 'width'),
      );

  Map<String, dynamic> toJson() => {
        'aspect_ratio': aspectRatio,
        'file_path': filePath,
        'height': height,
        'vote_average': voteAverage,
        'vote_count': voteCount,
        'width': width,
      };
}
