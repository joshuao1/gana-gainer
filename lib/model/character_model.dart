class Character {
  final int? id;
  final String character;
  final String translation;
  final String characterGroup;
  final String audio;
  DateTime? lastErrorDate;
  DateTime? nextTrainDate;
  DateTime? lastTrainDate;
  int level;
  int? streak;

  Character({
    this.id,
    required this.character,
    required this.translation,
    required this.characterGroup,
    required this.audio,
    this.lastErrorDate,
    this.nextTrainDate,
    this.lastTrainDate,
    required this.level,
    // TODO implement streak properly
    this.streak,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'character': character,
      'translation': translation,
      'character_group': characterGroup,
      'audio': audio,
      'last_error_date': lastErrorDate?.millisecondsSinceEpoch,
      'next_train_date': nextTrainDate?.millisecondsSinceEpoch,
      'last_train_date': lastTrainDate?.millisecondsSinceEpoch,
      'level': level,
      'streak': streak,
    };
  }

  // Character copyWith({
  //   DateTime? lastErrorDate,
  //   DateTime? nextTrainDate,
  //   int? level,
  //   int? streak,
  // }) {
  //   return Character(
  //     id: id,
  //     character: character,
  //     translation: translation,
  //     characterGroup: characterGroup,
  //     audio: audio,
  //     lastErrorDate: lastErrorDate ?? this.lastErrorDate,
  //     nextTrainDate: nextTrainDate ?? this.nextTrainDate,
  //     level: level ?? this.level,
  //     streak: streak ?? this.streak,
  //   );
  // }

  void correctAnswer() {
    if (lastTrainDate != null) {
      if (DateTime.now().difference(lastTrainDate!).inDays > 1) {
        level += 1;
      }
    }
    lastTrainDate = DateTime.now();
    nextTrainDate = DateTime.now().add(Duration(days: level));
  }

  void wrongAnswer() {
    level = 0;
    lastErrorDate = DateTime.now();
    lastTrainDate = DateTime.now();
    nextTrainDate = DateTime.now().add(Duration(days: level));
  }

  // void increaseStreak() {
  //   streak += 1;
  // }

  // void resetStreak() {
  //   streak = 0;
  // }

  static Character fromMap(Map<String, Object?> map) {
    return Character(
      id: map['id'] as int?,
      character: map['character'] as String,
      translation: map['translation'] as String,
      characterGroup: map['character_group'] as String,
      audio: map['audio'] as String,
      lastErrorDate: map['last_error_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_error_date'] as int)
          : null,
      nextTrainDate: map['next_train_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['next_train_date'] as int)
          : null,
      lastTrainDate: map['last_train_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_train_date'] as int)
          : null,
      level: map['level'] as int,
      streak: map['streak'] as int?,
    );
  }
}
