part of 'cast_detail_bloc.dart';

abstract class CastDetailEvent extends Equatable {
  const CastDetailEvent();

  @override
  List<Object> get props => [];
}

class CastImagesEvent extends CastDetailEvent {
  final int personId;

  const CastImagesEvent(this.personId);
  @override
  List<Object> get props => [personId];
}

class ActorDetailsEvent extends CastDetailEvent {
  final int personId;

  const ActorDetailsEvent(this.personId);
  @override
  List<Object> get props => [personId];
}
