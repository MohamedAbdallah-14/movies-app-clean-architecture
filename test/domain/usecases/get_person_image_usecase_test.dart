import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/cast_entity.dart';
import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:app_example/domain/repositories/movie_repository.dart';
import 'package:app_example/domain/repositories/person_repositories.dart';
import 'package:app_example/domain/usecases/get_person_images_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../entities_fake/cast_entity_fake.dart';
import '../../entities_fake/person_images_entity_fake.dart';


class MockMovieRepository extends Mock implements IPersonRepository {}

void main() {
  late GetPersonImagesUsecase usecase;
  late IPersonRepository repository;

  setUp(() {
    repository = MockMovieRepository();
    usecase = GetPersonImagesUsecase(repository);
  });

  const id = 1;

  test(
    'should return a list of PersonImageEntity when succeed',
    () async {
      // arrange
      when(() => repository.getPersonImages(id)).thenAnswer(
        (_) async => const Right(<PersonImageEntity>[personImagesEntity]),
      );
      // act
      final result = await usecase(id);
      // assert
      expect(result.isRight(), true);
    },
  );

  test(
    'should return a Failure when it doesn\'t succeed',
    () async {
      // arrange
      when(() => repository.getPersonImages(id)).thenAnswer(
        (_) async => Left(ServerFailure()),
      );
      // act
      final result = await usecase(id);
      // assert
      expect(result.isLeft(), true);
    },
  );
}
