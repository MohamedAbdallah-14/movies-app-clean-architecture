import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final String creditId;
  final String name;
  final int id;
  final String? posterPath;
  final String character;

  const CastEntity({
    required this.creditId,
    required this.name,
    required this.id,
    this.posterPath,
    required this.character,
  });

  @override
  List<Object?> get props => [id,creditId, name, posterPath, character];

  @override
  bool get stringify => true;
}
