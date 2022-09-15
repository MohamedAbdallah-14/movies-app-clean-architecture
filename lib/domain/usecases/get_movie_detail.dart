import '../../core/errors/failure.dart';
import '../entitites.dart/movie_detail_entity.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetailUsecase
    implements MovieDetailUseCase<MovieDetailEntity, int> {
  final IMovieRepository repository;

  GetMovieDetailUsecase(this.repository);

  @override
  Future<Either<Failure, MovieDetailEntity>> call(id) async {
    return await repository.getMovieDetail(id);
  }
}
