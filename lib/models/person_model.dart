class PersonModel {
  String id;
  String name;
  String picture;
  String details;

  PersonModel({
    required this.id,
    required this.name,
    this.picture = '',
    this.details = '',
  });

  factory PersonModel.fromMap(Map<String, dynamic> data, String documentId) {
    String name = data['name'];
    String picture = data['picture'] ?? '';
    String details = data['details'] ?? '';

    return PersonModel(
      id: documentId,
      name: name,
      picture: picture,
      details: details,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'picture': picture,
      'details': details,
    };
  }
}
