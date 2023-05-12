// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      profilePicture: json['profilePicture'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      odysseys: (json['odysseys'] as List<dynamic>?)
              ?.map((e) => Odyssey.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'friends': instance.friends,
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
      'age': instance.age,
      'odysseys': instance.odysseys,
    };

Odyssey _$OdysseyFromJson(Map<String, dynamic> json) => Odyssey(
      odysseyId: json['odysseyId'] as String? ?? '',
      odysseyName: json['odysseyName'] as String? ?? '',
      odysseyDetails: json['odysseyDetails'] as String? ?? '',
      people: (json['people'] as List<dynamic>?)
              ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => Entry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      resources: (json['resources'] as List<dynamic>?)
              ?.map((e) => Resource.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OdysseyToJson(Odyssey instance) => <String, dynamic>{
      'odysseyId': instance.odysseyId,
      'odysseyName': instance.odysseyName,
      'odysseyDetails': instance.odysseyDetails,
      'people': instance.people,
      'entries': instance.entries,
      'resources': instance.resources,
    };

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      personId: json['personId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      details: json['details'] as String? ?? '',
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'personId': instance.personId,
      'userId': instance.userId,
      'name': instance.name,
      'picture': instance.picture,
      'details': instance.details,
    };

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      entryId: json['entryId'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      link: json['link'] as String? ?? '',
      text: json['text'] as String? ?? '',
      date: json['date'] as String? ?? '',
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'entryId': instance.entryId,
      'picture': instance.picture,
      'link': instance.link,
      'text': instance.text,
      'date': instance.date,
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      resourceId: json['resourceId'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      note: json['note'] as String? ?? '',
      link: json['link'] as String? ?? '',
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'resourceId': instance.resourceId,
      'picture': instance.picture,
      'note': instance.note,
      'link': instance.link,
    };
