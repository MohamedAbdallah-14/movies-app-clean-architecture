import 'package:equatable/equatable.dart';

class ActorImageEntity extends Equatable {
  final String? imagePath;
  final num? voteAverage, width, height, voteCount;

  const ActorImageEntity(
      {this.imagePath,
      this.voteAverage,
      this.width,
      this.height,
      this.voteCount});

  @override
  List<Object?> get props => [imagePath, voteAverage, width, height, voteCount];
}
