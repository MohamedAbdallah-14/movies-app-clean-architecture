part of 'person_images_bloc.dart';

abstract class PersonImagesState extends Equatable {
  const PersonImagesState();
}

class PersonImagesInitial extends PersonImagesState {
  @override
  List<Object> get props => [];
}

class PersonImagesLoading extends PersonImagesState {
  @override
  List<Object> get props => [];
}

class PersonImagesFailure extends PersonImagesState {
  final String message;

  const PersonImagesFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PersonImagesLoaded extends PersonImagesState {
  final List<PersonImagesEntity> imagesEntity;

  const PersonImagesLoaded({
    required this.imagesEntity,
  });

  @override
  List<Object?> get props => [imagesEntity];
}
