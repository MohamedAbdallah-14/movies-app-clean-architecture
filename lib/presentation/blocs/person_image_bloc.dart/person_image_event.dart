part of 'person_image_bloc.dart';

abstract class PersonImageEvent extends Equatable {
  const PersonImageEvent();

  @override
  List<Object> get props => [];
}

class LoadPersonImageEvent extends PersonImageEvent {
  final int personId;

  const LoadPersonImageEvent({required this.personId});

  @override
  List<Object> get props => [personId];
}
