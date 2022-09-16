import '../../domain/entitites.dart/person_images_entity.dart';

class ImageModel extends PersonImagesEntity {
  const ImageModel({
    required this.personImage,
  }) : super(
          images: personImage,
        );

  final String personImage;

  factory ImageModel.fromMap(Map<String, dynamic> json) => ImageModel(
        personImage: json["file_path"] ?? 'No information',
      );

  Map<String, dynamic> toMap() {
    return {
      "file_path": personImage,
    };
  }
}
