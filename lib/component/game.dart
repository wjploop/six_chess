import 'package:flutter/material.dart';

import 'game_data.dart';

class Game extends StatefulWidget {
  final Widget child;

  const Game({Key? key, required this.child}) : super(key: key);

  static GameControl of(BuildContext context) {
    return context.findAncestorStateOfType<GameControl>()!;
  }

  @override
  GameControl createState() => GameControl();
}

class GameControl extends State<Game> {
  GameState _state = GameState.created;

  final List<List> _data = List.generate(
      5,
      (row) => List.generate(4, (col) {
            return 1;
          }));

  void updateState(GameState state) {
    setState(() {
      _state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameData(_state, _data, child: widget.child);
  }
}
