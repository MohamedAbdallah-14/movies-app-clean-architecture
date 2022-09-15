import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/failure.dart';
import '../entitites.dart/person_entity.dart';
import '../repositories/person_repository.dart';
import 'usecase.dart';
@lazySingleton
class GetPersonDataUseCase implements MovieDetailUseCase<PersonEntity, int> {
  final IPersonRepository repository;

  GetPersonDataUseCase(this.repository);

  @override
  Future<Either<Failure, PersonEntity>> call(int id) async =>
      await repository.getPersonDetails(id);
}
