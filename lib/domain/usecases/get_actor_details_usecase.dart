import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/actor_entity.dart';
import 'package:app_example/domain/entitites.dart/actor_image_entity.dart';
import 'package:app_example/domain/repositories/actor_repository.dart';
import 'package:app_example/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetActorDetailsUseCase implements MovieDetailUseCase<ActorEntity, int?> {
  final IActorRepository actorRepository;

  GetActorDetailsUseCase(this.actorRepository);

  @override
  Future<Either<Failure, ActorEntity>> call(int? actorId) async {
    if (actorId == null) return Left(NullParamFailure());
    return actorRepository.getActorDetails(actorId);
  }
}

class GetActorImagesUseCase implements UseCase<ActorImageEntity, int?> {
  final IActorRepository actorRepository;

  GetActorImagesUseCase(this.actorRepository);

  @override
  Future<Either<Failure, List<ActorImageEntity>>> call(int? actorId) async {
    if (actorId == null) return Left(NullParamFailure());
    return actorRepository.getActorImages(actorId);
  }
}
