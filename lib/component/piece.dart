import 'package:flutter/material.dart';

enum PieceType { black, white }

class Piece extends StatelessWidget {
  final double width;
  final PieceType type;

  const Piece({Key? key, required this.width, this.type = PieceType.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: Image.asset("assets/images/black_piece.png"),
    );
  }
}
