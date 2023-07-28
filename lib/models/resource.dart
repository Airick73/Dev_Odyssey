class ResourceModel {
  String id;
  String details;
  String? picture;
  String? note;
  String? link;

  ResourceModel({
    required this.id,
    required this.details,
    this.picture = '',
    this.note = '',
    this.link = '',
  });
}
