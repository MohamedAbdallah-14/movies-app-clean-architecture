import 'package:app_example/core/errors/exceptions.dart';
import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/data/datasources/person_remote_data_source.dart';
import 'package:app_example/domain/entitites.dart/person_entity.dart';
import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:app_example/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class PersonRepositoryImplementation implements IPersonRepository {
  final PersonRemoteDataSource _remoteDataSource;

  const PersonRepositoryImplementation({
    required PersonRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, PersonEntity>> getPersonDetails(int personId) async {
    try {
      return Right(await _remoteDataSource.getPersonDetails(personId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PersonImagesEntity>> getPersonImages(
      int personId) async {
    try {
      return Right(await _remoteDataSource.getPersonImages(personId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
