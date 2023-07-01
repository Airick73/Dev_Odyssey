import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class DevOdysseyUser {
  //from firebase auth user
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  //custom properties
  List<DevOdysseyUser> friends;
  String bio;
  int age;
  List<Odyssey> odysseys;

  DevOdysseyUser({
    required this.uid,
    this.email,
    this.displayName = '',
    this.photoURL = '',
    this.friends = const [],
    this.bio = '',
    this.age = 0,
    this.odysseys = const [],
  });

  factory DevOdysseyUser.fromJson(Map<String, dynamic> json) =>
      _$DevOdysseyUserFromJson(json);
  Map<String, dynamic> toJson() => _$DevOdysseyUserToJson(this);
}

@JsonSerializable()
class Odyssey {
  String odysseyId;
  String odysseyName;
  String odysseyDetails;
  List<Person> people;
  List<Entry> entries;
  List<Resource> resources;

  Odyssey({
    this.odysseyId = '',
    this.odysseyName = '',
    this.odysseyDetails = '',
    this.people = const [],
    this.entries = const [],
    this.resources = const [],
  });

  factory Odyssey.fromJson(Map<String, dynamic> json) =>
      _$OdysseyFromJson(json);
  Map<String, dynamic> toJson() => _$OdysseyToJson(this);
}

@JsonSerializable()
class Person {
  String personId;
  String userId; // Optional: userId if the person is a user in the app
  String name;
  String picture;
  String details;

  Person({
    this.personId = '',
    this.userId = '',
    this.name = '',
    this.picture = '',
    this.details = '',
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable()
class Entry {
  String entryId;
  String picture;
  String link;
  String text;
  String date;

  Entry({
    this.entryId = '',
    this.picture = '',
    this.link = '',
    this.text = '',
    this.date = '',
  });

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}

@JsonSerializable()
class Resource {
  String resourceId;
  String picture;
  String note;
  String link;

  Resource({
    this.resourceId = '',
    this.picture = '',
    this.note = '',
    this.link = '',
  });

  factory Resource.fromJson(Map<String, dynamic> json) =>
      _$ResourceFromJson(json);
  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}
