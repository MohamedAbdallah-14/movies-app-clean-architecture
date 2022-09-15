import '../../core/errors/exceptions.dart';
import '../../core/errors/failure.dart';
import '../datasources/person_remote_data_source.dart';
import '../../domain/entitites.dart/person_entity.dart';
import '../../domain/entitites.dart/person_images_entity.dart';
import '../../domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

class PersonRepositoryImplementation implements IPersonRepository {
  final IPersonRemoteDataSource _remoteDataSource;

  const PersonRepositoryImplementation({
    required IPersonRemoteDataSource remoteDataSource,
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
  Future<Either<Failure,List<PersonImagesEntity>>> getPersonImages(
      int personId) async {
    try {
      final personImage = await _remoteDataSource.getPersonImages(personId);
      return Right(personImage.profilePathModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
