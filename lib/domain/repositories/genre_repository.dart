import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entitites.dart/genre_entity.dart';

abstract class IGenreRepository {
 Future<Either<Failure, List<GenreEntity>>> getAllGenres();
}