import 'package:flutter/material.dart';

enum GameState {
  created,
  waitingPlayerJoin,
  waitingPlayerA,
  waitingPlayerB,
  finished,
}

class GameData extends InheritedWidget {
  @override
  final Widget child;

  final List<List> data;
  final GameState state;

  GameData(this.state, this.data, {required this.child, Key? key})
      : super(key: key, child: child);

  static GameData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GameData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
