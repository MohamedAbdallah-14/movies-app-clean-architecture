import 'package:app_example/data/models/safe_convert.dart';

import '../../domain/entitites.dart/person_entity.dart';

class PersonModel extends PersonEntity {
  // 1963-12-18
  final String birthday;
  // Acting
  final String knownForDepartment;
  // 287
  final int id;
  // Brad Pitt
  final String name;
  final List<String> alsoKnownAs;
  // 2
  final int gender;
  // William Bradley "Brad" Pitt (born December 18, 1963) is an American actor and film producer. Pitt has received two Academy Award nominations and four Golden Globe Award nominations, winning one. He has been described as one of the world's most attractive men, a label for which he has received substantial media attention. Pitt began his acting career with television guest appearances, including a role on the CBS prime-time soap opera Dallas in 1987. He later gained recognition as the cowboy hitchhiker who seduces Geena Davis's character in the 1991 road movie Thelma & Louise. Pitt's first leading roles in big-budget productions came with A River Runs Through It (1992) and Interview with the Vampire (1994). He was cast opposite Anthony Hopkins in the 1994 drama Legends of the Fall, which earned him his first Golden Globe nomination. In 1995 he gave critically acclaimed performances in the crime thriller Seven and the science fiction film 12 Monkeys, the latter securing him a Golden Globe Award for Best Supporting Actor and an Academy Award nomination.Four years later, in 1999, Pitt starred in the cult hit Fight Club. He then starred in the major international hit as Rusty Ryan in Ocean's Eleven (2001) and its sequels, Ocean's Twelve (2004) and Ocean's Thirteen (2007). His greatest commercial successes have been Troy (2004) and Mr. & Mrs. Smith (2005).Pitt received his second Academy Award nomination for his title role performance in the 2008 film The Curious Case of Benjamin Button. Following a high-profile relationship with actress Gwyneth Paltrow, Pitt was married to actress Jennifer Aniston for five years. Pitt lives with actress Angelina Jolie in a relationship that has generated wide publicity. He and Jolie have six children—Maddox, Pax, Zahara, Shiloh, Knox, and Vivienne.Since beginning his relationship with Jolie, he has become increasingly involved in social issues both in the United States and internationally. Pitt owns a production company named Plan B Entertainment, whose productions include the 2007 Academy Award winning Best Picture, The Departed.
  final String biography;
  // 10.647
  final double popularity;
  // Shawnee, Oklahoma, USA
  final String placeOfBirth;
  // /kU3B75TyRiCgE270EyZnHjfivoq.jpg
  final String profilePath;
  // false
  final bool adult;
  // nm0000093
  final String imdbId;

  PersonModel({
    this.birthday = "",
    this.knownForDepartment = "",
    this.id = 0,
    this.name = "",
    required this.alsoKnownAs,
    this.gender = 0,
    this.biography = "",
    this.popularity = 0.0,
    this.placeOfBirth = "",
    this.profilePath = "",
    this.adult = false,
    this.imdbId = "",
  }) : super(
          name: name,
          id: id,
          description: biography,
          birthday: birthday,
        );

  factory PersonModel.fromJson(Map<String, dynamic>? json) => PersonModel(
        birthday: asString(json, 'birthday'),
        knownForDepartment: asString(json, 'known_for_department'),
        id: asInt(json, 'id'),
        name: asString(json, 'name'),
        alsoKnownAs:
            asList(json, 'also_known_as').map((e) => e.toString()).toList(),
        gender: asInt(json, 'gender'),
        biography: asString(json, 'biography'),
        popularity: asDouble(json, 'popularity'),
        placeOfBirth: asString(json, 'place_of_birth'),
        profilePath: asString(json, 'profile_path'),
        adult: asBool(json, 'adult'),
        imdbId: asString(json, 'imdb_id'),
      );

  Map<String, dynamic> toJson() => {
        'birthday': birthday,
        'known_for_department': knownForDepartment,
        'id': id,
        'name': name,
        'also_known_as': alsoKnownAs.map((e) => e).toList(),
        'gender': gender,
        'biography': biography,
        'popularity': popularity,
        'place_of_birth': placeOfBirth,
        'profile_path': profilePath,
        'adult': adult,
        'imdb_id': imdbId,
      };
}
