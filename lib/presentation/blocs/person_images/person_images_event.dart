part of 'person_images_bloc.dart';

abstract class PersonImagesEvent extends Equatable {
  const PersonImagesEvent();
}

class LoadImagesEvent extends PersonImagesEvent {
  final int id;

  const LoadImagesEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
