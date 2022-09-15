import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:app_example/domain/usecases/get_person_images_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'person_image_event.dart';
part 'person_image_state.dart';

class PersonImageBloc extends Bloc<PersonImageEvent, PersonImageState> {
  final GetPersonImagesUsecase getPersonImagesUsecase;

  PersonImageBloc(this.getPersonImagesUsecase) : super(PersonImageInitial()) {
    on<PersonImageEvent>(getPersonImage);
  }

  Future<void> getPersonImage(event, emit) async {
    var getPersonImages = await getPersonImagesUsecase.call(event.personId);
    getPersonImages.fold(
      (failure) => emit(const PersonImageError('Something went wrong!')),
      (success) => emit(
        PersonImageLoaded(
          personImages: success,
        ),
      ),
    );
  }
}
