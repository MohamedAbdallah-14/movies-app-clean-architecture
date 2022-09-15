part of 'person_image_bloc.dart';

abstract class PersonImageState extends Equatable {
  const PersonImageState();

  @override
  List<Object> get props => [];
}

class PersonImageInitial extends PersonImageState {}

class PersonImageLoaded extends PersonImageState {
  final List<PersonImageEntity> personImages;

  const PersonImageLoaded({required this.personImages});

  @override
  List<Object> get props => [personImages];
}

class PersonImageError extends PersonImageState {
  final String message;

  const PersonImageError(this.message);

   @override
  List<Object> get props => [message];
}
