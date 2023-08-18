class ResourceModel {
  String id;
  String? picture;
  String? note;
  String? link;

  ResourceModel({
    required this.id,
    this.picture = '',
    this.note = '',
    this.link = '',
  });

  factory ResourceModel.fromMap(Map<String, dynamic> data, String documentId) {
    String picture = data['picture'] ?? '';
    String note = data['note'] ?? '';
    String link = data['link'] ?? '';

    return ResourceModel(
      id: documentId,
      picture: picture,
      note: note,
      link: link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'picture': picture,
      'note': note,
      'link': link,
    };
  }
}
