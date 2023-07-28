class EntryModel {
  String id;
  String picture;
  String link;
  String text;
  String date;

  EntryModel({
    required this.id,
    required this.picture,
    required this.link,
    required this.text,
    required this.date,
  });

  factory EntryModel.fromMap(Map<String, dynamic> data, String documentId) {
    String picture = data['picture'] ?? '';
    String link = data['link'] ?? '';
    String text = data['text'] ?? '';
    String date = data['date'] ?? '';

    return EntryModel(
      id: documentId,
      picture: picture,
      link: link,
      text: text,
      date: date,
    );
  }
}
