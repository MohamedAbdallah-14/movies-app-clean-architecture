import 'package:app_example/core/errors/exceptions.dart';
import 'package:app_example/data/datasources/actor_remote_datasource.dart';
import 'package:app_example/data/models/actor_images_model.dart';
import 'package:app_example/data/models/actor_model.dart';
import 'package:app_example/data/repositories/actor_repository_imp.dart';
import 'package:app_example/domain/repositories/actor_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockActorRemoteDataSource extends Mock implements IActorRemoteDataSource {
}

void main() {
  late IActorRepository actorRepository;
  late IActorRemoteDataSource actorRemoteDataSource;
  const actorId = "10";
  setUp(() {
    actorRemoteDataSource = MockActorRemoteDataSource();
    actorRepository = ActorRepositoryImplementation(actorRemoteDataSource);
  });

  group("test get actor details", () {
    test(
      'should return a ActorModel when the method getActorDetails is called',
      () async {
        const actorModel = ActorModel();
        // arrange
        when(() => actorRemoteDataSource.getActorDetails(actorId))
            .thenAnswer((_) async => actorModel);
        // act
        final result = await actorRepository.getActorDetails(actorId);
        // assert
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a server failure when the method getActorDetails is called unsuccessfully',
      () async {
        // arrange
        when(() => actorRemoteDataSource.getActorDetails(actorId))
            .thenThrow(const ServerException('message'));
        // act
        final result = await actorRepository.getActorDetails(actorId);
        // assert
        expect(result.isLeft(), true);
      },
    );
  });


    group("test get actor images", () {
    test(
      'should return a ActorImageResponseModel when the method getActorImages is called successfully',
      () async {
        const actorImagesResponseModel= ActorImagesResponse();
        // arrange
        when(() => actorRemoteDataSource.getActorImages(actorId))
            .thenAnswer((_) async => actorImagesResponseModel);
        // act
        final result = await actorRepository.getActorImages(actorId);
        // assert
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a server failure when the method getActorImages is called unsuccessfully',
      () async {
        // arrange
        when(() => actorRemoteDataSource.getActorImages(actorId))
            .thenThrow(const ServerException('something wrong'));
        // act
        final result = await actorRepository.getActorImages(actorId);
        // assert
        expect(result.isLeft(), true);
      },
    );
  });
}
