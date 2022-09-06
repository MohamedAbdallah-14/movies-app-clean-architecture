part of 'person_details_bloc.dart';

abstract class PersonDetailsEvent extends Equatable {
  const PersonDetailsEvent();
}

class LoadPersonDetailsEvent extends PersonDetailsEvent {
  final int id;

  const LoadPersonDetailsEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
