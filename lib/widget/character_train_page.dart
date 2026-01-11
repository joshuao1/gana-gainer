import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/model/character_model.dart';
import 'package:language_app/notifier/character_notifier.dart';
import 'package:language_app/widget/styled_container.dart';
import 'package:provider/provider.dart';

class CharacterTrainerPage extends StatefulWidget {
  const CharacterTrainerPage({super.key});

  @override
  State<CharacterTrainerPage> createState() => _CharacterTrainerPageState();
}

class _CharacterTrainerPageState extends State<CharacterTrainerPage> {
  // final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  List<Character>? _characterList;
  int index = 0;

  late FocusNode inputFocusNode;

  @override
  void initState() {
    super.initState();

    inputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    inputFocusNode.dispose();
    super.dispose();
  }

  void checkAnswer() {
    print("Expected Answer ${_characterList![index].translation}");
    if (_characterList![index].translation == _controller.value.text) {
      setState(() {
        index += 1;
        if (index >= _characterList!.length) {
          index = 0;
        }
      });
      _controller.clear();
      inputFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final characterNotifier = context.watch<CharacterNotifier>();
    _characterList = characterNotifier.characters;

    if (characterNotifier.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text("Character Trainer")),
      body: SafeArea(
        child: StyledContainer(
          child: Column(
            children: [
              Text(
                _characterList![index].character,
                style: TextStyle(fontSize: 60),
              ),
              CupertinoTextField(
                controller: _controller,
                autocorrect: false,
                enableSuggestions: false,
                onSubmitted: (String value) {
                  checkAnswer();
                  inputFocusNode.requestFocus();
                },
                autofocus: true,
                focusNode: inputFocusNode,
              ),
              ElevatedButton.icon(
                onPressed: () => checkAnswer(),
                label: Text("Next"),
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
