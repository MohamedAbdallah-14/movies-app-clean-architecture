import 'dart:async';

import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_person_images_usecase.dart';

part 'person_images_event.dart';
part 'person_images_state.dart';

class PersonImagesBloc extends Bloc<PersonImagesEvent, PersonImagesState> {
  final GetPersonImagesUseCase useCase;
  PersonImagesBloc({required this.useCase}) : super(PersonImagesInitial()) {
    on<LoadImagesEvent>(getPersonImage);
  }

  Future<void> getPersonImage(
      LoadImagesEvent event, Emitter<PersonImagesState> emit) async {
    emit(PersonImagesLoading());
    var response = await useCase(event.id);
    response.fold(
      (failure) => emit(
        const PersonImagesFailure(
          'Something went wrong!',
        ),
      ),
      (success) => emit(
        PersonImagesLoaded(
          imagesEntity: success,
        ),
      ),
    );
  }
}
