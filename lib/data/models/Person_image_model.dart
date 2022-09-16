

import 'package:equatable/equatable.dart';

import 'image.dart';

class PersonImageModel extends Equatable {
  const PersonImageModel({
    required this.id,
    required this.profilePathModel,
  });
  final int id;
  final List<ImageModel> profilePathModel;

  factory PersonImageModel.fromMap(Map<String, dynamic> json) =>
      PersonImageModel(
        id: json["id"] ?? 1,
        profilePathModel: List<ImageModel>.from(
            json["profiles"].map((x) => ImageModel.fromMap(x))),
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