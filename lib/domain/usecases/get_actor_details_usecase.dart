import 'package:app_example/domain/entitites.dart/actor_details_entity.dart';
import 'package:app_example/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../repositories/movie_repository.dart';

class GetActorDetailsUseCase implements ActorDetailsUseCase<ActorDetailsEntity, int> {
  final IMovieRepository repository;

  GetActorDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ActorDetailsEntity>> call(id) async {
    return await repository.getActorDetails(id);
  }
}
