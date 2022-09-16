// ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:app_example/domain/entitites.dart/genre_entity.dart';

class Genre extends GenreEntity {
  // ignore: annotate_overrides
  final int id;

  final String name;

  const Genre({
    required this.name,
    required this.id,
  }) : super(
          id: id,
          genreName: name,
        );

 
  factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"] ?? 1,
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

