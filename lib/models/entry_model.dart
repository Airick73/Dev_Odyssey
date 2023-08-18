class EntryModel {
  String id;
  String text;
  String date;

  EntryModel({
    required this.id,
    required this.text,
    required this.date,
  });

  factory EntryModel.fromMap(Map<String, dynamic> data, String documentId) {
    String text = data['text'] ?? '';
    String date = data['date'] ?? '';

    return EntryModel(
      id: documentId,
      text: text,
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'date': date,
    };
  }
}
