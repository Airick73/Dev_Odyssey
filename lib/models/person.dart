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
}
