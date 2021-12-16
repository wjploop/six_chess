import 'dart:math';

import 'package:flutter/material.dart';
import 'package:six_chess/component/game.dart';
import 'package:six_chess/component/piece.dart';

import 'game_data.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var width = screenWidth * 1;
    // 棋盘为 3 * 4 的格子构成
    // 在棋盘的四周再加上一个格子的边距，故实际占据的比例为 5 * 6
    //

    var height = width * 6 / 5;

    // 棋子与格子的比例为 1:3
    var pieceWidth = width / 5 / 1.5;

    var gridWidth = width / 5;

    GameData data = GameData.of(context);

    List<Widget> pieces(List<List> data) {
      List<Widget> widgets = [];
      int n = data.length;
      int m = data[0].length;
      for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
          widgets.add(Positioned(
              top: i * gridWidth - pieceWidth / 2,
              left: j * gridWidth - pieceWidth / 2,
              child: Piece(width: pieceWidth)));
        }
      }
      return widgets;
    }

    return GestureDetector(
      onTap: () {
        Game.of(context).updateState(
            GameState.values[Random().nextInt(GameState.values.length)]);
      },
      child: Center(
        child: Container(
          color: Color(0xff9ead86),
          width: width,
          height: height,
          child: CustomPaint(
            painter: BoardPainter(gridWidth),
            child: Stack(
              children: pieces(data.data),
            ),
          ),
        ),
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  final double width;

  final Paint _paint;

  BoardPainter(this.width)
      : _paint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 3;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(width, width);
    for (int i = 0; i < 5; i++) {
      canvas.drawLine(
          Offset(0, i * width),
          Offset(
            3 * width,
            i * width,
          ),
          _paint);
    }
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(
          Offset(i * width, 0), Offset(i * width, 4 * width), _paint);
    }
    // 画直线会导致直角有缝隙不好看，故覆盖一个边框
    canvas.drawRect(Offset.zero & Size(3 * width, 4 * width), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
