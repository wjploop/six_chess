import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:six_chess/component/Log.dart';
import 'package:six_chess/component/piece.dart';

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

const N = 5;
const M = 4;

const LIST_NONE = [-1, -1];

class GameControl extends State<Game> {
  GameState _state = GameState.created;

  final List<List> _data = INIT_PIECE_DATA;

  final List<List> _status = INIT_PIECE_STATUS;

  void visitGrid(action(y, x)) {
    for (int i = 0; i < N; i++) {
      for (int j = 0; j < M; j++) {
        action(i, j);
      }
    }
  }

  // 遍历是否有匹配项
  List find(match(y, x)) {
    for (int i = 0; i < N; i++) {
      for (int j = 0; j < M; j++) {
        if (match(i, j)) {
          return [i, j];
        }
      }
    }
    return LIST_NONE;
  }

  void onTap(int i, int j) {
    log("onTap $i $j");

    List selected = find((y, x) => _status[y][x] == PieceStatus.selected);

    if (selected == LIST_NONE) {
      log("select $i $j");
      if (_data[i][j] != 0) {
        _status[i][j] = PieceStatus.selected;
        log("find place able ");
        _updatePlaceAble(_findPlaceAble(i, j));
      }
      return;
    }

    log("has selected $selected");
    // todo 使用List 比较元素时，比较的是内存地址
    if (containsList(_findPlaceAble(selected[0], selected[1]), [i, j])) {
      _findPlaceAble(selected[0], selected[1]).forEach((p) {
        _status[p[0]][p[1]] = PieceStatus.none;
      });
      log("move from $selected to ${[i, j]}");
      _movePiece(selected, [i, j]);
      return;
    }
    visitGrid((y, x) => {
          if (_status[y][x] == PieceStatus.selected)
            {_status[y][x] = PieceStatus.none}
          else if (_status[y][x] == PieceStatus.palce_able)
            {_status[y][x] = PieceStatus.none}
        });

    _status[i][j] = PieceStatus.selected;
    _updatePlaceAble(_findPlaceAble(i, j));

    setState(() {});
  }

  bool containsList(List list, List target) {
    if(list.isEmpty) {
      return false;
    }
    log("check containList $list target $target");
    for (List e in list) {
      if (e[0] == target[0] && e[1] == target[1]) {
        return true;
      }
    }
    return false;
  }

  _movePiece(List f, List t) {
    var piece = _data[f[0]][f[1]];
    _data[f[0]][f[1]] = 0;
    _data[t[0]][t[1]] = piece;

    _status[f[0]][f[1]] = PieceStatus.last_action_from;
    _status[t[0]][t[1]] = PieceStatus.last_action_current;
    setState(() {});
  }

  void _updatePlaceAble(List list) {
    if (list.isNotEmpty) {
      for (List p in list) {
        _status[p[0]][p[1]] = PieceStatus.palce_able;
      }
      setState(() {});
    }
  }

  List _findPlaceAble(int i, int j) {
    List dirs = _find4Direction(i, j);
    var res = [];
    for (List pos in dirs) {
      if (_data[pos[0]][pos[1]] == 0) {
        res.add(pos);
      }
    }
    return res;
  }

  List _find4Direction(int i, int j) {
    var res = [];
    if (i - 1 >= 0) {
      res.add([i - 1, j]);
    }
    if (i + 1 < N) {
      res.add([i + 1, j]);
    }
    if (j - 1 >= 0) {
      res.add([i, j - 1]);
    }
    if (j + 1 < M) {
      res.add([i, j + 1]);
    }
    return res;
  }

  void updateState(GameState state) {
    setState(() {
      _state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var data = _deepCopyTwoDimension(_data);
    // var status = _deepCopyTwoDimension(_status);
    //
    log(_data.toString().replaceAll("], ", "]\n"));
    log(_status.toString().replaceAll("], ", "]\n"));
    return GameData(_state, _data, _status, child: widget.child);
  }

  _deepCopyTwoDimension(List<List> arr) {
    return List.generate(arr.length, (index) => List.from(arr[index]));
  }
}
