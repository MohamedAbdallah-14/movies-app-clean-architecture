import 'package:equatable/equatable.dart';

class ActorEntity extends Equatable {
  final String? id, name, biography, birthday, profilePicture;

  const ActorEntity(
      {this.id, this.name, this.biography, this.birthday, this.profilePicture});

  @override
  List<Object?> get props => [id, name, biography, birthday, profilePicture];
}
