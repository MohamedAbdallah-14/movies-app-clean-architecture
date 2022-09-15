import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/failure.dart';
import '../entitites.dart/person_images_entity.dart';
import '../repositories/person_repository.dart';
import 'usecase.dart';
@lazySingleton
class GetPersonImagesUsecase implements ProfileImagesUseCase<PersonImagesEntity, int> {
  final IPersonRepository repository;

  GetPersonImagesUsecase(this.repository);

  @override
  Future<Either<Failure, List<PersonImagesEntity>>> call(id) async {
    return await repository.getPersonImages(id);
  }
}
