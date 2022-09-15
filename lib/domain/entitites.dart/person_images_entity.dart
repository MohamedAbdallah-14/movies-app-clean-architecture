
import 'package:equatable/equatable.dart';

class PersonImageEntity extends Equatable {

  final String? personPathImage;


  const PersonImageEntity({
   required this.personPathImage
  });

  @override
  List<Object?> get props => [personPathImage];

  @override
  bool get stringify => true;
}
