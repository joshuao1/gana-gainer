class Character {
  final int? id;
  final String character;
  final String translation;
  final String characterGroup;
  final String audio;
  final DateTime? lastDate;
  final DateTime? nextDate;
  final int level;

  Character({
    this.id,
    required this.character,
    required this.translation,
    required this.characterGroup,
    required this.audio,
    this.lastDate,
    this.nextDate,
    required this.level,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'character': character,
      'translation': translation,
      'character_group': characterGroup,
      'audio': audio,
      'last_date': lastDate?.millisecondsSinceEpoch,
      'next_date': nextDate?.millisecondsSinceEpoch,
      'level': level,
    };
  }

  Character copyWith({DateTime? lastDate, DateTime? nextDate, int? level}) {
    return Character(
      id: id,
      character: character,
      translation: translation,
      characterGroup: characterGroup,
      audio: audio,
      lastDate: lastDate ?? this.lastDate,
      nextDate: nextDate ?? this.nextDate,
      level: level ?? this.level,
    );
  }

  static Character fromMap(Map<String, Object?> map) {
    return Character(
      id: map['id'] as int?,
      character: map['character'] as String,
      translation: map['translation'] as String,
      characterGroup: map['character_group'] as String,
      audio: map['audio'] as String,
      lastDate: map['last_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_date'] as int)
          : null,
      nextDate: map['next_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['next_date'] as int)
          : null,
      level: map['level'] as int,
    );
  }
}
