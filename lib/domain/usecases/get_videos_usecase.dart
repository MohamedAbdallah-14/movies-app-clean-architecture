import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entitites.dart/video_entity.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

class GetVideosUsecase implements UseCase <VideoEntity, int> {
  final IMovieRepository repository;

  GetVideosUsecase(this.repository);

  @override
  Future<Either<Failure, List<VideoEntity>>> call(id) async {
    return await repository.getVideos(id);
  }
}