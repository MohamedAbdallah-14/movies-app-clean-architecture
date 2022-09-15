part of 'person_details_bloc.dart';

abstract class PersonDetailsState extends Equatable {
  const PersonDetailsState();
}

class PersonDetailsInitial extends PersonDetailsState {
  @override
  List<Object> get props => [];
}

class PersonDetailsLoading extends PersonDetailsState {
  @override
  List<Object> get props => [];
}

class PersonDetailsFailure extends PersonDetailsState {
  final String message;

  const PersonDetailsFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PersonDetailsLoaded extends PersonDetailsState {
  final PersonEntity personEntity;

  const PersonDetailsLoaded({
    required this.personEntity,
  });

  @override
  List<Object?> get props => [personEntity];
}
