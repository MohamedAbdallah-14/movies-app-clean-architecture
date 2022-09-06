import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/usecases/get_person_data_usecase.dart';
import 'package:app_example/domain/usecases/get_person_images_usecase.dart';
import 'package:app_example/presentation/blocs/person_images/person_images_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../entities_fake/mock_person_images.dart';

class MockPersonImagesUseCase extends Mock implements GetPersonImagesUseCase {}

void main() {
  late PersonImagesBloc bloc;
  late GetPersonImagesUseCase useCase;
  useCase = MockPersonImagesUseCase();
  bloc = PersonImagesBloc(useCase: useCase);

  group("get person images", () {
    test('should get images from the person data use case', () async {
      when(() => useCase(287))
          .thenAnswer((_) async => const Right(personImagesEntity));
      bloc.add(const LoadImagesEvent(id: 287));
      await untilCalled(() => useCase(287));
      verify(() => useCase(287));
    });
    blocTest<PersonImagesBloc, PersonImagesState>(
      'emits [LoadingState, LoadedState] when successful',
      build: () => PersonImagesBloc(useCase: useCase),
      act: (PersonImagesBloc bloc) {
        when(() => useCase(287))
            .thenAnswer((_) async => const Right(personImagesEntity));
        bloc.add(const LoadImagesEvent(id: 287));
      },
      expect: () =>
      [
        PersonImagesLoading(),
        const PersonImagesLoaded(imagesEntity: personImagesEntity),
      ],
    );

    blocTest<PersonImagesBloc, PersonImagesState>(
      'emits [LoadingState, ErrorState] when  getting data fails',
      build: () => PersonImagesBloc(useCase: useCase),
      act: (PersonImagesBloc bloc) {
        when(() => useCase(287)).thenAnswer(
              (_) async => Left(ServerFailure()),
        );
        bloc.add(const LoadImagesEvent(id: 287));
      },
      expect: () =>
      [
        PersonImagesLoading(),
        const PersonImagesFailure('Something went wrong!'),
      ],
    );
  });
}