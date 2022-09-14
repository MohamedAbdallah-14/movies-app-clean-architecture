import 'package:app_example/data/models/cast_image_model.dart';
import 'package:equatable/equatable.dart';

class CastImageEntity extends Equatable {
  final int id;
  final List<Profiles> profiles;

  const CastImageEntity(this.id, this.profiles);

  @override
  List<Object> get props => [id, profiles];
}
