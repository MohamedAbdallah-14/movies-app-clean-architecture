import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/data/models/cast_image_model.dart';
import 'package:app_example/domain/entitites.dart/actor_details_entity.dart';
import 'package:app_example/domain/entitites.dart/cast_images_entity.dart';
import 'package:app_example/domain/usecases/get_actor_details_usecase.dart';
import 'package:app_example/domain/usecases/get_cast_images_usecase.dart';
import 'package:app_example/presentation/blocs/cast_detail/bloc/cast_detail_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCastImagesUseCase extends Mock implements GetCastImagesUsecase {}

class MockGetActorDetailsUseCase extends Mock implements GetActorDetailsUseCase {}

void main() {
  late CastDetailBloc castDetailBloc;
  late MockGetCastImagesUseCase mockGetCastImagesUseCase;
  late MockGetActorDetailsUseCase mockGetActorDetailsUseCase;

  setUp(() {
    mockGetCastImagesUseCase = MockGetCastImagesUseCase();
    mockGetActorDetailsUseCase = MockGetActorDetailsUseCase();
    castDetailBloc = CastDetailBloc(mockGetCastImagesUseCase, mockGetActorDetailsUseCase);
  });

  test(
    'testing CastDetailInitial',
    () {
      expect(castDetailBloc.state.runtimeType, CastDetailInitial);
    },
  );

  group('Actor Details bloc (Success)', () {
    blocTest<CastDetailBloc, CastDetailState>(
      'testing CastDetailLoaded state (Actor Images)',
      setUp: () {
        when(() => mockGetCastImagesUseCase(1)).thenAnswer((_) async => const Right(CastImageEntity(1, <Profiles>[])));
      },
      build: () => castDetailBloc,
      act: (bloc) => bloc.add(const CastImagesEvent(1)),
      expect: () => <CastDetailState>[
        CastDetailLoading(loading: true),
        CastDetailLoaded(castImageEntity: const CastImageEntity(1, <Profiles>[])),
      ],
    );

    blocTest<CastDetailBloc, CastDetailState>(
      'testing CastDetailLoaded state (Actor Details)',
      setUp: () {
        when(() => mockGetActorDetailsUseCase(1)).thenAnswer((_) async => const Right(ActorDetailsEntity('', '', '', 2)));
      },
      build: () => castDetailBloc,
      act: (bloc) => bloc.add(const ActorDetailsEvent(1)),
      expect: () => <CastDetailState>[CastDetailLoading(loading: true), ActorDetailsLoaded(actorDetailsEntity: ActorDetailsEntity('', '', '', 2))],
    );
  });

  group('Actor Details bloc (Failure)', () {
    blocTest<CastDetailBloc, CastDetailState>(
      'testing CastDetailError state (Actor Images)',
      setUp: () {
        when(() => mockGetCastImagesUseCase(2)).thenAnswer((_) async => Left(InvalidPageFailure('Invalid page')));
      },
      build: () => castDetailBloc,
      act: (bloc) => bloc.add(const CastImagesEvent(2)),
      expect: () => <CastDetailState>[CastDetailLoading(loading: true), CastDetailError('Something went wrong!')],
    );

    blocTest<CastDetailBloc, CastDetailState>(
      'testing CastDetailError state ( Acctor Details)',
      setUp: () {
        when(() => mockGetActorDetailsUseCase(2)).thenAnswer((_) async => Left(InvalidPageFailure('Invalid page')));
      },
      build: () => castDetailBloc,
      act: (bloc) => bloc.add(const ActorDetailsEvent(2)),
      expect: () => <CastDetailState>[CastDetailLoading(loading: true), CastDetailError('Something went wrong!')],
    );
  });
}
