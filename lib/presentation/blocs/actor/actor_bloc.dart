import 'dart:async';

import 'package:app_example/domain/entitites.dart/actor_entity.dart';
import 'package:app_example/domain/entitites.dart/actor_image_entity.dart';
import 'package:app_example/domain/usecases/get_actor_details_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'actor_event.dart';

part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final GetActorDetailsUseCase getActorDetailsUseCase;
  final GetActorImagesUseCase getActorImagesUseCase;

  ActorBloc(
      {
      required this.getActorDetailsUseCase,
      required this.getActorImagesUseCase})
      : super(ActorInitial()) {
    on<ActorDetailsEvent>(getActorDetails);
    on<ActorImagesEvent>(getActorImages);
  }

  Future<void> getActorDetails(
      ActorDetailsEvent event, Emitter<ActorState> emit) async {
    emit(ActorLoading());
    final actorDetails = await getActorDetailsUseCase(event.actorId);
    actorDetails.fold(
        (l) => emit(ActorError(l.toString())), (r) => ActorDetails(r));
  }

  Future<void> getActorImages(
      ActorImagesEvent event, Emitter<ActorState> emit) async {
    emit(ActorLoading());
    final actorDetails = await getActorImagesUseCase(event.actorId);
    actorDetails.fold(
        (l) => emit(ActorError(l.toString())), (r) => ActorImagesState(r));
  }
}
