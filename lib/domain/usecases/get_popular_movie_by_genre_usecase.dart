import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entitites.dart/movie_entity.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

class GetMovieByGenreUsecase implements UseCase<MovieEntity, int> {
  final IMovieRepository repository;

  GetMovieByGenreUsecase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(int id) async {
    return await repository.getMovieByGenre(id);
  }
}