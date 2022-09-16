import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/actor_entity.dart';
import 'package:app_example/domain/entitites.dart/actor_image_entity.dart';
import 'package:app_example/domain/usecases/get_actor_details_usecase.dart';
import 'package:app_example/presentation/blocs/actor/actor_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockActorBloc extends MockBloc<ActorEvent, ActorState>
    implements ActorBloc {}

class MockGetActorDetailsUsecase extends Mock
    implements GetActorDetailsUseCase {}

class MockGetActorImagesUsecase extends Mock implements GetActorImagesUseCase {}

void main() {
  late ActorBloc actorBloc;

  late MockGetActorImagesUsecase actorImagesUseCase;

  late MockGetActorDetailsUsecase actorDetailsUseCase;
  const actorId = "10";
  setUp(() {
    actorImagesUseCase = MockGetActorImagesUsecase();
    actorDetailsUseCase = MockGetActorDetailsUsecase();
    actorBloc = ActorBloc(
        getActorDetailsUseCase: actorDetailsUseCase,
        getActorImagesUseCase: actorImagesUseCase);
  });

  test(
    'ActorBloc at initial state ',
    () {
      expect(actorBloc.state.runtimeType, ActorInitial);
    },
  );

  blocTest<ActorBloc, ActorState>(
    'emits ActorLoading => ActorDetails when ActorDetailsEvent is added.',
    setUp: () {
      when(() => actorDetailsUseCase(actorId))
          .thenAnswer((_) async => const Right(ActorEntity()));
    },
    build: () => actorBloc,
    act: (bloc) => bloc.add(const ActorDetailsEvent(actorId)),
    expect: () =>
        const <ActorState>[ActorLoading(), ActorDetails(ActorEntity())],
  );
  blocTest<ActorBloc, ActorState>(
    'emits ActorLoading => ActorError when ActorDetailsEvent is added. with null actorId',
    setUp: () {
      when(() => actorDetailsUseCase(actorId))
          .thenAnswer((_) async => Left(NullParamFailure()));
    },
    build: () => actorBloc,
    act: (bloc) => bloc.add(const ActorDetailsEvent(actorId)),
    expect: () => <ActorState>[
      const ActorLoading(),
      ActorError(message: NullParamFailure().toString())
    ],
  );

  blocTest<ActorBloc, ActorState>(
    'emits ActorLoading => ActorError when ActorDetailsEvent is added. with server expection',
    setUp: () {
      when(() => actorDetailsUseCase(actorId))
          .thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => actorBloc,
    act: (bloc) => bloc.add(const ActorDetailsEvent(actorId)),
    expect: () => <ActorState>[
      const ActorLoading(),
      ActorError(message: ServerFailure().toString())
    ],
  );
  blocTest<ActorBloc, ActorState>(
    'emits [ActorLoading, ActorImages] when ActorImagesEvent is added.',
    setUp: () {
      when(() => actorImagesUseCase(actorId))
          .thenAnswer((_) async => const Right([ActorImageEntity()]));
    },
    build: () => actorBloc,
    act: (bloc) => bloc.add(const ActorImagesEvent(actorId)),
    expect: () => const <ActorState>[
      ActorLoading(),
      ActorImagesState([ActorImageEntity()])
    ],
  );
  blocTest<ActorBloc, ActorState>(
    'emits [ActorLoading, ActorImages] when ActorImagesEvent is added.',
    setUp: () {
      when(() => actorImagesUseCase(actorId))
          .thenAnswer((_) async => const Right([ActorImageEntity()]));
    },
    build: () => actorBloc,
    act: (bloc) => bloc.add(const ActorImagesEvent(actorId)),
    expect: () => const <ActorState>[
      ActorLoading(),
      ActorImagesState([ActorImageEntity()])
    ],
  );

  blocTest<ActorBloc, ActorState>(
    'emits ActorLoading => ActorError when ActorImagesEvent is added. with null actorId',
    setUp: () {
      when(() => actorImagesUseCase(actorId))
          .thenAnswer((_) async => Left(NullParamFailure()));
    },
    build: () => actorBloc,
    act: (bloc) => bloc.add(const ActorImagesEvent(actorId)),
    expect: () => <ActorState>[
      const ActorLoading(),
      ActorError(message: NullParamFailure().toString())
    ],
  );

  blocTest<ActorBloc, ActorState>(
    'emits ActorLoading => ActorError when ActorImagesEvent is added. with server expection',
    setUp: () {
      when(() => actorImagesUseCase(actorId))
          .thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => actorBloc,
    act: (bloc) => bloc.add(const ActorImagesEvent(actorId)),
    expect: () => <ActorState>[
      const ActorLoading(),
      ActorError(message: ServerFailure().toString())
    ],
  );
}
