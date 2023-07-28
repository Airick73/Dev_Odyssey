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

  factory ResourceModel.fromMap(Map<String, dynamic> data, String documentId) {
    String details = data['details'] ?? '';
    String picture = data['picture'] ?? '';
    String note = data['note'] ?? '';
    String link = data['link'] ?? '';

    return ResourceModel(
      id: documentId,
      details: details,
      picture: picture,
      note: note,
      link: link,
    );
  }
}
