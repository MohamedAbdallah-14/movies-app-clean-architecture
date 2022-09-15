import '../../core/errors/failure.dart';
import '../entitites.dart/genre_entity.dart';
import '../repositories/genre_repository.dart';
import 'usecase.dart';
import 'package:dartz/dartz.dart';

class GetAllGenresUsecase implements UseCase<GenreEntity, NoParams> {
  final IGenreRepository repository;

  GetAllGenresUsecase(this.repository);
 
  @override
  Future<Either<Failure, List<GenreEntity>>> call(NoParams noParams) async {
    return await repository.getAllGenres();
  }
}
