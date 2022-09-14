import 'package:app_example/domain/entitites.dart/cast_images_entity.dart';

class CastImageModel extends CastImageEntity {
  CastImageModel({required this.id, required this.profiles})
      : super(
          0,
          [],
        );
  final int id;
  final List<Profiles> profiles;

  factory CastImageModel.fromMap(Map<String, dynamic> json) => CastImageModel(
        id: json['id'],
        profiles: json['profiles'] == null ? [] : List.from(json['profiles']).map((e) => Profiles.fromJson(e)).toList(),
      );
}

class Profiles {
  Profiles({
    required this.filePath,
  });

  late final String filePath;

  Profiles.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['file_path'] = filePath;

    return _data;
  }
}
