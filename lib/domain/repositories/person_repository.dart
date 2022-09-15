import '../../core/errors/failure.dart';
import '../entitites.dart/person_entity.dart';
import '../entitites.dart/person_images_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IPersonRepository {
  Future<Either<Failure,List<PersonImagesEntity>>> getPersonImages(int personId);
  Future<Either<Failure, PersonEntity>> getPersonDetails(int personId);
}
