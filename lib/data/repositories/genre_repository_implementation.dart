import '../../core/errors/exceptions.dart';
import '../datasources/genre_remote_datasource.dart';
import '../../domain/entitites.dart/genre_entity.dart';
import '../../core/errors/failure.dart';
import '../../domain/repositories/genre_repository.dart';
import 'package:dartz/dartz.dart';

class GenreRepositoryImplementation extends IGenreRepository {
  final IGenreRemoteDataSource remoteDataSource;

  GenreRepositoryImplementation(this.remoteDataSource);
  @override
  Future<Either<Failure, List<GenreEntity>>> getAllGenres() async {
    try {
      final allGenres = await remoteDataSource.getAllGenres();
      return Right(allGenres.genres);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
