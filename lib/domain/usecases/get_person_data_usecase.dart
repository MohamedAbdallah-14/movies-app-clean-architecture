import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/person_entity.dart';
import 'package:app_example/domain/repositories/person_repository.dart';
import 'package:app_example/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPersonDataUseCase implements MovieDetailUseCase<PersonEntity, int> {
  final IPersonRepository _repository;

  @override
  Future<Either<Failure, PersonEntity>> call(int id) async =>
      await _repository.getPersonDetails(id);
  const GetPersonDataUseCase({
    required IPersonRepository repository,
  }) : _repository = repository;
}
