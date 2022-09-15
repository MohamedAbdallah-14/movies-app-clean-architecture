import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/usecases/get_person_detils_usecase.dart';
import 'package:app_example/presentation/blocs/person_details/person_details_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../entities_fake/person_entity_fake.dart';


class MockPersonDetailsUseCase extends Mock implements GetPersonDataUseCase {}

void main() {
  late PersonDetailsBloc bloc;
  late GetPersonDataUseCase useCase;
  useCase = MockPersonDetailsUseCase();
  bloc = PersonDetailsBloc(useCase: useCase);

  group("get person details", () {
    test('should get data from the person data use case', () async {
      when(() => useCase(287))
          .thenAnswer((_) async => const Right(personEntity));
      bloc.add(const LoadPersonDetailsEvent(id: 287));
      await untilCalled(() => useCase(287));
      verify(() => useCase(287));
    });
    blocTest<PersonDetailsBloc, PersonDetailsState>(
      'emits [LoadingState, LoadedState] when successful',
      build: () => PersonDetailsBloc(useCase: useCase),
      act: (PersonDetailsBloc bloc) {
        when(() => useCase(287))
            .thenAnswer((_) async => const Right(personEntity));
        bloc.add(const LoadPersonDetailsEvent(id: 287));
      },
      expect: () => [
        PersonDetailsLoading(),
        const PersonDetailsLoaded(personEntity: personEntity),
      ],
    );

    blocTest<PersonDetailsBloc, PersonDetailsState>(
      'emits [LoadingState, ErrorState] when  getting data fails',
      build: () => PersonDetailsBloc(useCase: useCase),
      act: (PersonDetailsBloc bloc) {
        when(() => useCase(287)).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        bloc.add(const LoadPersonDetailsEvent(id: 287));
      },
      expect: () => [
        PersonDetailsLoading(),
        const PersonDetailsFailure('Something went wrong!'),
      ],
    );
  });
}
