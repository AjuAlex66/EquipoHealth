class Note {
  String? notesId;
  String? userid;
  String? folderId;
  String? noteTitle;
  String? noteContent;
  DateTime? timestamp;
  int? isActive;

  Note({
    this.notesId,
    this.userid,
    this.folderId,
    this.noteTitle,
    this.noteContent,
    this.timestamp,
    this.isActive,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      notesId: json['notesId'],
      userid: json['userid'],
      folderId: json['folderId'],
      noteTitle: json['noteTitle'],
      noteContent: json['noteContent'],
      timestamp: json['timestamp'] != null ? DateTime.tryParse(json['timestamp']) : DateTime.now(),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notesId': notesId,
      'userid': userid,
      'folderId': folderId,
      'noteTitle': noteTitle,
      'noteContent': noteContent,
      'timestamp': timestamp,
      'isActive': isActive,
    };
  }
}
