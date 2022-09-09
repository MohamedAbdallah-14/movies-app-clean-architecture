import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:app_example/domain/repositories/movie_repository.dart';
import 'package:app_example/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPersonImagesUsecase implements UseCase<PersonImageEntity, int> {
  final IMovieRepository repository;

  GetPersonImagesUsecase(this.repository);

  @override
  Future<Either<Failure, List<PersonImageEntity>>> call(id) async {
    return await repository.getPersonImages(id);
  }
}
