part of 'cast_detail_bloc.dart';

@immutable
abstract class CastDetailState extends Equatable {}

class CastDetailInitial extends CastDetailState {
  @override
  List<Object> get props => [];
}

class CastDetailLoading extends CastDetailState {
  final bool loading;

  CastDetailLoading({required this.loading});
  @override
  List<Object> get props => [];
}

class CastDetailError extends CastDetailState {
  final String message;

  CastDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class CastDetailLoaded extends CastDetailState {
  final CastImageEntity castImageEntity;

  CastDetailLoaded({required this.castImageEntity});

  @override
  List<Object> get props => [castImageEntity];
}

class ActorDetailsLoaded extends CastDetailState {
  final ActorDetailsEntity actorDetailsEntity;
  ActorDetailsLoaded({required this.actorDetailsEntity});

  @override
  List<Object> get props => [actorDetailsEntity];
}
