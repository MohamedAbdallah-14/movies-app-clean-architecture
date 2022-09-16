import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entitites.dart/movie_entity.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

class GetTopRatMoviesUsecase implements UseCase<MovieEntity, int> {
  final IMovieRepository repository;

  GetTopRatMoviesUsecase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(int page) async {
    if (page <= 0) {
      return Left(InvalidPageFailure('Invalid page'));
    }
    return await repository.getTopRatedMovies(page);
  }
}
