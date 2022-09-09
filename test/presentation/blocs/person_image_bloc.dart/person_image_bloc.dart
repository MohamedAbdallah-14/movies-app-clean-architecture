import 'package:app_example/core/errors/failure.dart';
import 'package:app_example/domain/entitites.dart/person_images_entity.dart';
import 'package:app_example/domain/usecases/get_person_images_usecase.dart';
import 'package:app_example/presentation/blocs/person_image_bloc.dart/person_image_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPersonImageUsecase extends Mock implements GetPersonImagesUsecase {}

void main() {
  late PersonImageBloc personImageBloc;
  late MockGetPersonImageUsecase mockGetPersonImageUsecase;

  setUp(() {
    mockGetPersonImageUsecase = MockGetPersonImageUsecase();

    personImageBloc = PersonImageBloc(mockGetPersonImageUsecase);
  });

  test(
    'personImageBloc should have initial state as [PersonImageInitial]', () {
      expect(personImageBloc.state.runtimeType, PersonImageInitial());
    },
  );

  blocTest<PersonImageBloc, PersonImageState>(
    'emits [personImageBloc] when LoadPersonImageEvent is added.',
    setUp: () {
      when(() => mockGetPersonImageUsecase(1)).thenAnswer((_) async => const Right(<PersonImageEntity>[]));
    },
    build: () => personImageBloc,
    act: (bloc) => bloc.add(const LoadPersonImageEvent(personId: 1)),
    expect: () => const <PersonImageState>[PersonImageLoaded(personImages: <PersonImageEntity>[])],
  );

  blocTest<PersonImageBloc, PersonImageState>(
    'emits [personImageBloc] when LoadCaLoadPersonImageEventstEvent is added.',
    setUp: () {
      when(() => mockGetPersonImageUsecase(1)).thenAnswer((_) async => Left(InvalidPageFailure('Invalid page')));
    },
    build: () => personImageBloc,
    act: (bloc) => bloc.add(const LoadPersonImageEvent(personId: 1)),
    expect: () => const <PersonImageState>[PersonImageError('Something went wrong!')],
  );
}
