import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/person_entity.dart';
import 'package:app_example/domain/repositories/person_repositories.dart';
import 'package:app_example/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPersonDataUseCase implements MovieDetailUseCase<PersonEntity, int> {
  final IPersonRepository repository;

  GetPersonDataUseCase(this.repository);

  @override
  Future<Either<Failure, PersonEntity>> call(id) async {
    return await repository.getPersonDetails(id);
  }
}
