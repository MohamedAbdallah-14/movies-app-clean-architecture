import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/actor_entity.dart';
import 'package:app_example/domain/entitites.dart/actor_image_entity.dart';
import 'package:app_example/domain/repositories/actor_repository.dart';
import 'package:app_example/domain/usecases/get_actor_details_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockActorRepository extends Mock implements IActorRepository {}

void main() {
  late GetActorDetailsUseCase getActorDetailsUseCase;
  late GetActorImagesUseCase getActorImagesUseCase;
  late IActorRepository actorRepository;
  const actorId = "10";
  setUp(() {
    actorRepository = MockActorRepository();
    getActorDetailsUseCase = GetActorDetailsUseCase(actorRepository);
    getActorImagesUseCase = GetActorImagesUseCase(actorRepository);
  });

  group("test actor details usecase", () {
    test(
      'should return actor details when is succeed',
      () async {
        // arrange
        when(() => actorRepository.getActorDetails(actorId)).thenAnswer(
          (_) async => const Right(ActorEntity()),
        );
        // act
        final result = await getActorDetailsUseCase(actorId);
        // assert
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a failure',
      () async {
        // arrange
        when(() => actorRepository.getActorDetails(actorId)).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        // act
        final result = await actorRepository.getActorDetails(actorId);
        // assert
        expect(result.isLeft(), true);
      },
    );
  });
  group("test actor images usecase", () {
    test(
      'should return actor images when is succeed',
      () async {
        // arrange
        when(() => actorRepository.getActorImages(actorId)).thenAnswer(
          (_) async => const Right([ActorImageEntity()]),
        );
        // act
        final result = await getActorImagesUseCase(actorId);
        // assert
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a failure',
      () async {
        // arrange
        when(() => actorRepository.getActorImages(actorId)).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        // act
        final result = await actorRepository.getActorImages(actorId);
        // assert
        expect(result.isLeft(), true);
      },
    );
  });
}
