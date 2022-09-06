import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:app_example/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../repositories/person_repository.dart';

class GetPersonImagesUseCase
    implements MovieDetailUseCase<PersonImagesEntity, int> {
  final IPersonRepository _repository;

  @override
  Future<Either<Failure, PersonImagesEntity>> call(int id) async =>
      await _repository.getPersonImages(id);
  const GetPersonImagesUseCase({
    required IPersonRepository repository,
  }) : _repository = repository;
}
