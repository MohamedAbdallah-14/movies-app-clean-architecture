import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entitites.dart/cast_entity.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

class GetCastUsecase implements UseCase<CastEntity, int> {
  final IMovieRepository repository;

  GetCastUsecase(this.repository);
 
  @override
  Future<Either<Failure, List<CastEntity>>> call(id) async {
    return await repository.getCastCrew(id);
  }
}
