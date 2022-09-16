part of 'actor_bloc.dart';

abstract class ActorEvent extends Equatable {
  const ActorEvent();

  @override
  List<Object?> get props => [];
}

class ActorDetailsEvent extends ActorEvent {
  final String? actorId;

  const ActorDetailsEvent(this.actorId);

  @override
  List<Object?> get props => [actorId];
}

class ActorImagesEvent extends ActorEvent {
  final String? actorId;

  const ActorImagesEvent(this.actorId);

  @override
  List<Object?> get props => [actorId];
}
