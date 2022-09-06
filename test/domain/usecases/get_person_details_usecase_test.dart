import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/person_entity.dart';
import 'package:app_example/domain/repositories/person_repository.dart';
import 'package:app_example/domain/usecases/get_person_data_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../entities_fake/mock_person_entity.dart';

class MockPersonRepository extends Mock implements IPersonRepository {}

void main() {
  late IPersonRepository repo;
  late GetPersonDataUseCase useCase;
  setUp(() {
    repo = MockPersonRepository();
    useCase = GetPersonDataUseCase(repository: repo);
  });

  test(
    'should return a PersonEntity when succeed',
    () async {
      // arrange
      when(() => repo.getPersonDetails(287)).thenAnswer(
        (_) async => const Right(personEntity),
      );
      // act
      final result = await useCase(287);
      // assert
      expect(result.isRight(), true);
      verify(() => repo.getPersonDetails(287));
      verifyNoMoreInteractions(repo);
    },
  );

  test(
    'should return a failure when it fails',
    () async {
      // arrange
      when(() => repo.getPersonDetails(287)).thenAnswer(
        (_) async => Left(ServerFailure()),
      );
      // act
      final result = await useCase(287);
      // assert
      expect(result.isLeft(), true);
      verify(() => repo.getPersonDetails(287));
      verifyNoMoreInteractions(repo);
    },
  );
}
