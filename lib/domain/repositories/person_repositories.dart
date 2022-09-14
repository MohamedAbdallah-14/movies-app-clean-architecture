import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/person_entity.dart';
import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IPersonRepository {
  Future<Either<Failure, List<PersonImageEntity>>> getPersonImages(int id);
  Future<Either<Failure, PersonEntity>> getPersonDetails(int personId);
}
