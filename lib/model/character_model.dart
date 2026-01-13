class Character {
  final int? id;
  final String character;
  final String translation;
  final String characterGroup;
  final String audio;

  Character({
    this.id,
    required this.character,
    required this.translation,
    required this.characterGroup,
    required this.audio,
  });

  static Character fromMap(Map<String, Object?> map) {
    return Character(
      id: map['id'] as int?,
      character: map['character'] as String,
      translation: map['translation'] as String,
      characterGroup: map['character_group'] as String,
      audio: map['audio'] as String,
    );
  }
}
