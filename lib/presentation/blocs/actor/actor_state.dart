part of 'actor_bloc.dart';

abstract class ActorState extends Equatable {
  const ActorState();

  @override
  List<Object?> get props => [];
}

class ActorInitial extends ActorState {
  const ActorInitial();
}

class ActorLoading extends ActorState {
  const ActorLoading();
}

class ActorDetails extends ActorState {
  final ActorEntity actorEntity;

  const ActorDetails(this.actorEntity);

  @override
  List<Object?> get props => [actorEntity];
}

class ActorImagesState extends ActorState {
  final List<ActorImageEntity> actorImages;

  const ActorImagesState(this.actorImages);

  @override
  List<Object?> get props => [actorImages];
}

class ActorError extends ActorState {
  final String? message;

  const ActorError({this.message});

  @override
  List<Object?> get props => [message];
}
