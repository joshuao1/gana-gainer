class CharacterSession {
  int? id;
  DateTime date;
  List errors;
  List content;
  Duration duration;

  CharacterSession({
    required this.date,
    required this.content,
    required this.errors,
    required this.duration,
  });

  double accuracy() {
    return (content.length - errors.length) / content.length * 100;
  }
}
