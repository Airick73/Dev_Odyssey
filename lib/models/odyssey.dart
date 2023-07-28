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
    Map<String, PersonModel> people = data['people'];
    Map<String, EntryModel> entries = data['entries'];
    Map<String, ResourceModel> resources = data['resources'];

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
