
class Notes{
  String notesTitle = "", notesText = "";

  Notes({required this.notesTitle, required this.notesText});

  toJson(){
      return {'notesTitle':notesTitle, 'notesText':notesText};
  }
  Notes.fromJson(Map<dynamic, dynamic> json)
    : notesTitle = json["notesTitle"].toString(),
        notesText = json["notesText"].toString();

}