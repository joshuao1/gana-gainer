import 'package:flutter/material.dart';
import 'package:language_app/data/character_dao.dart';
import 'package:language_app/model/character_model.dart';

class CharacterNotifier extends ChangeNotifier {
  final CharacterDao dao;
  CharacterNotifier(this.dao);

  List<Character> _characters = [];
  bool _isLoading = false;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _characters = await dao.getAll();
    _isLoading = false;
    notifyListeners();
  }
}
