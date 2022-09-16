import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entitites.dart/person_entity.dart';
import '../../../domain/usecases/get_person_data_usecase.dart';

part 'person_details_event.dart';
part 'person_details_state.dart';
// @injectable  

class PersonDetailsBloc extends Bloc<PersonDetailsEvent, PersonDetailsState> {
  final GetPersonDataUseCase useCase;
  PersonDetailsBloc({required this.useCase}) : super(PersonDetailsInitial()) {
    on<LoadPersonDetailsEvent>(getPersonDetails);
  }

  Future<void> getPersonDetails(
      LoadPersonDetailsEvent event, Emitter<PersonDetailsState> emit) async {
    emit(PersonDetailsLoading());
    var response = await useCase(event.id);
    response.fold(
      (failure) => emit(
        const PersonDetailsFailure(
          'Something went wrong!',
        ),
      ),
      (success) => emit(
        PersonDetailsLoaded(
          personEntity: success,
        ),
      ),
    );
  }
}
