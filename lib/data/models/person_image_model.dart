import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:equatable/equatable.dart';

class PersonImageModel extends Equatable {
  const PersonImageModel({
    required this.id,
    required this.profilePathModel,
  });
  final int id;
  final List<ProfileModel> profilePathModel;

  factory PersonImageModel.fromMap(Map<String, dynamic> json) =>
      PersonImageModel(
        id: json["id"] ?? 1,
        profilePathModel: List<ProfileModel>.from(
            json["profiles"].map((x) => ProfileModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profiles': profilePathModel,
    };
  }

  @override
  List<Object> get props => [id, profilePathModel];
}

class ProfileModel extends PersonImageEntity {
  const ProfileModel({
    required this.personImage,
  }) : super(
          personPathImage: personImage,
        );

  final String personImage;

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        personImage: json["file_path"] ?? 'No information',
      );

  Map<String, dynamic> toMap() {
    return {
      "file_path": personImage,
    };
  }
}
