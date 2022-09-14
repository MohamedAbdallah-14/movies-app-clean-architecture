import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/cast_images_entity.dart';
import 'package:app_example/domain/repositories/movie_repository.dart';
import 'package:app_example/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetCastImagesUsecase implements CastImageUseCase<CastImageEntity, int> {
  final IMovieRepository repository;

  GetCastImagesUsecase(this.repository);

  @override
  Future<Either<Failure, CastImageEntity>> call(id) async {
    return await repository.getCastImages(id);
  }
}
