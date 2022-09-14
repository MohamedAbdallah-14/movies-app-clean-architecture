import 'package:app_example/core/utils/api_utils.dart';
import 'package:app_example/data/models/cast_image_model.dart';
import 'package:app_example/domain/entitites.dart/cast_images_entity.dart';
import 'package:app_example/domain/usecases/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entitites.dart/actor_details_entity.dart';

part 'cast_detail_event.dart';
part 'cast_detail_state.dart';

class CastDetailBloc extends Bloc<CastDetailEvent, CastDetailState> {
  final CastImageUseCase castImagesUsecase;
  final ActorDetailsUseCase actorDetailsUseCase;

  CastDetailBloc(
    this.castImagesUsecase,
    this.actorDetailsUseCase,
  ) : super(CastDetailInitial()) {
    on<CastImagesEvent>(getCastImagesDetail);
    on<ActorDetailsEvent>(getActorDetails);
  }
  Future<void> getCastImagesDetail(event, emit) async {
    emit(CastDetailLoading(loading: true));
    var getCastImages = await castImagesUsecase(event.personId);
    getCastImages.fold(
      (failure) => emit(CastDetailError('Something went wrong!')),
      (success) => emit(CastDetailLoaded(castImageEntity: success)),
    );
  }

  List<Widget> imageSlider(List<Profiles> images) {
    return images
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage('${ApiUrls.requestImage(item.filePath)}'),
                            fit: BoxFit.cover,
                          )),
                    )),
              ),
            ))
        .toList();
  }

  Future<void> getActorDetails(event, emit) async {
    emit(CastDetailLoading(loading: true));
    var getActorDetails = await actorDetailsUseCase(event.personId);
    getActorDetails.fold(
      (failure) => emit(CastDetailError('Something went wrong!')),
      (success) => emit(ActorDetailsLoaded(actorDetailsEntity: success)),
    );
  }
}
