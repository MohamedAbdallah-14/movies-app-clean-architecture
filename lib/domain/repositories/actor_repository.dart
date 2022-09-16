import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/actor_entity.dart';
import 'package:app_example/domain/entitites.dart/actor_image_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IActorRepository {
  Future<Either<Failure, ActorEntity>> getActorDetails(String? actorId);

  Future<Either<Failure, List<ActorImageEntity>>> getActorImages(String? actorId);
}
