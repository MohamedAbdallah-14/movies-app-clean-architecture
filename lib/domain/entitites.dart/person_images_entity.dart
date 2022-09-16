import 'package:equatable/equatable.dart';

class PersonImagesEntity extends Equatable{
  final String images;

  const PersonImagesEntity({
    required this.images,
  });

  @override
  List<Object?> get props => [images];
  @override
  bool? get stringify => true;
}