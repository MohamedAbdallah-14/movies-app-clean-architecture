import 'package:app_example/core/errors/exceptions.dart';
import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/data/datasources/actor_remote_datasource.dart';
import 'package:app_example/domain/entitites.dart/actor_entity.dart';
import 'package:app_example/domain/entitites.dart/actor_image_entity.dart';
import 'package:app_example/domain/repositories/actor_repository.dart';
import 'package:dartz/dartz.dart';

class ActorRepositoryImplementation extends IActorRepository {
  final IActorRemoteDataSource actorRemoteDataSource;

  ActorRepositoryImplementation(this.actorRemoteDataSource);

  @override
  Future<Either<Failure, ActorEntity>> getActorDetails(String? actorId) async {
    try {
      final result = await actorRemoteDataSource.getActorDetails(actorId);
      return Right(result.toActorEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ActorImageEntity>>> getActorImages(String? actorId) async {
    try {
      final result = await actorRemoteDataSource.getActorImages(actorId);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
