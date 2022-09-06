import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/repositories/person_repository.dart';
import 'package:app_example/domain/usecases/get_person_data_usecase.dart';
import 'package:app_example/domain/usecases/get_person_images_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../entities_fake/mock_person_images.dart';

class MockPersonRepository extends Mock implements IPersonRepository {}

void main() {
  late IPersonRepository repo;
  late GetPersonImagesUseCase useCase;
  setUp(() {
    repo = MockPersonRepository();
    useCase = GetPersonImagesUseCase(repository: repo);
  });

  test(
    'should return a PersonImagesEntity when succeed',
        () async {
      // arrange
      when(() => repo.getPersonImages(66633)).thenAnswer(
            (_) async => const Right(personImagesEntity),
      );
      // act
      final result = await useCase(66633);
      // assert
      expect(result.isRight(), true);
      verify(() => repo.getPersonImages(66633));
      verifyNoMoreInteractions(repo);
    },
  );

  test(
    'should return a failure when it fails',
        () async {
      // arrange
      when(() => repo.getPersonImages(66633)).thenAnswer(
            (_) async => Left(ServerFailure()),
      );
      // act
      final result = await useCase(66633);
      //verify(repo.getPersonImages(66633));
      // assert
      expect(result.isLeft(), true);
      verify(() => repo.getPersonImages(66633));
      verifyNoMoreInteractions(repo);
    },
  );
}