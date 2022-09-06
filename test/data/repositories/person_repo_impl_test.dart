import 'package:app_example/core/errors/exceptions.dart';
import 'package:app_example/data/datasources/person_remote_data_source.dart';
import 'package:app_example/data/models/person_model.dart';
import 'package:app_example/data/repositories/person_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../models_fake/mock_person_images_model.dart';
import '../../models_fake/mock_person_model.dart';

class MockPersonRemoteDataSource extends Mock
    implements PersonRemoteDataSource {}

void main() {
  late PersonRepositoryImplementation repository;
  late PersonRemoteDataSource dataSource;

  setUp(() {
    dataSource = MockPersonRemoteDataSource();
    repository = PersonRepositoryImplementation(
      remoteDataSource: dataSource,
    );
  });

  group("getPersonDetails", () {
    test(
      'should return a PersonModel when the method getPersonDetails calls to the datasource',
      () async {
        // arrange
        when(() => dataSource.getPersonDetails(287))
            .thenAnswer((_) async => personModel);
        // act
        final result = await repository.getPersonDetails(287);
        // assert
        verify(() => dataSource.getPersonDetails(287));
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a server failure when the method getPersonDetails call is unsuccessful to the datasource',
      () async {
        // arrange
        when(() => dataSource.getPersonDetails(287))
            .thenThrow(const ServerException('Something went Wrong!'));
        // act
        final result = await repository.getPersonDetails(287);
        // assert
        verify(() => dataSource.getPersonDetails(287));
        expect(result.isLeft(), true);
      },
    );
  });
  group("getPersonImages", () {
    test(
      'should return a PersonImagesModel when the method getPersonImages calls to the datasource',
      () async {
        // arrange
        when(() => dataSource.getPersonImages(66633))
            .thenAnswer((_) async => personImagesModel);
        // act
        final result = await repository.getPersonImages(66633);
        // assert
        verify(()=> dataSource.getPersonImages(66633));
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a server failure when the method getPersonImages call is unsuccessful to the datasource',
      () async {
        // arrange
        when(() => dataSource.getPersonImages(66633))
            .thenThrow(const ServerException('Something went Wrong!'));
        // act
        final result = await repository.getPersonImages(66633);
        // assert
        verify(()=> dataSource.getPersonImages(66633));
        expect(result.isLeft(), true);
      },
    );
  });
}
