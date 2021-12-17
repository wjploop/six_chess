import 'package:flutter/material.dart';
import 'package:six_chess/component/piece.dart';

enum GameState {
  created,
  waitingPlayerJoin,
  waitingPlayerA,
  waitingPlayerB,
  finished,
}



List<List> INIT_PIECE_DATA = [
  [1, 1, 1, 1],
  [1, 0, 0, 1],
  [0, 0, 0, 0],
  [-1, 0, 0, -1],
  [-1, -1, -1, -1],
];

List<List> INIT_PIECE_STATUS =
    List.generate(5, (index) => List.generate(4, (i) => PieceStatus.none));

class GameData extends InheritedWidget {
  @override
  final Widget child;

  final GameState state;

  final List<List> data;
  final List<List> status;

  GameData(this.state, this.data, this.status, {required this.child, Key? key})
      : super(key: key, child: child);

  static GameData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GameData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

