import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:injectable/injectable.dart';
import 'package:modular_test/modular_test.dart';

import '../../../domain/entitites.dart/person_images_entity.dart';
import '../../../domain/usecases/get_person_images_usecase.dart';

part 'person_images_event.dart';
part 'person_images_state.dart';

@injectable
class PersonImagesBloc extends Bloc<PersonImagesEvent, PersonImagesState> {
  final GetPersonImagesUsecase useCase;
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
