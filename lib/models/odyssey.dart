import 'package:dev_odyssey/models/entry.dart';
import 'package:dev_odyssey/models/person.dart';
import 'package:dev_odyssey/models/resource.dart';

class OdysseyModel {
  String id;
  String name;
  String details;
  Map<String, PersonModel> people;
  Map<String, EntryModel> entries;
  Map<String, ResourceModel> resources;

  OdysseyModel({
    required this.id,
    required this.name,
    required this.details,
    this.people = const {},
    this.entries = const {},
    this.resources = const {},
  });

  factory OdysseyModel.fromMap(Map<String, dynamic> data, String documentId) {
    String name = data['name'];
    String details = data['details'];

    Map<String, dynamic> peopleData = data['people'] ?? {};
    Map<String, PersonModel> people = peopleData
        .map((key, value) => MapEntry(key, PersonModel.fromMap(value, key)));

    Map<String, dynamic> entriesData = data['entries'] ?? {};
    Map<String, EntryModel> entries = entriesData
        .map((key, value) => MapEntry(key, EntryModel.fromMap(value, key)));

    Map<String, dynamic> resourcesData = data['resources'] ?? {};
    Map<String, ResourceModel> resources = resourcesData
        .map((key, value) => MapEntry(key, ResourceModel.fromMap(value, key)));

    return OdysseyModel(
        id: documentId,
        name: name,
        details: details,
        people: people,
        entries: entries,
        resources: resources);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'details': details,
      'people': people,
      'entries': entries,
      'resources': resources
    };
  }
}
