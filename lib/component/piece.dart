import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:six_chess/component/constant.dart';

enum PieceStatus {
  none,
  selected,
  palce_able,
  last_action_from,
  last_action_current,
}

class Piece extends StatefulWidget {
  final double width;
  final int type;
  final PieceStatus status;

  const Piece(
      {Key? key,
      required this.width,
      required this.type,
      this.status = PieceStatus.none})
      : super(key: key);

  @override
  _PieceState createState() => _PieceState();
}

class _PieceState extends State<Piece> {
  // late AnimationController controller;
  //
  // late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    // controller =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    // scale = Tween(begin: 1.0, end: 1.3).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    var piece;
    if (widget.type > 0) {
      piece = Image.asset("assets/images/black_piece.png");
    } else if (widget.type < 0) {
      piece = Image.asset("assets/images/white_piece.png");
    } else {
      piece = Container();
    }
    return Container(
      width: widget.width,
      height: widget.width,
      child: Stack(
        children: [
          Positioned(
              child: Center(
                child: AnimatedOpacity(
                  duration: duration_piece_scale,
                  opacity: widget.status == PieceStatus.palce_able ? 1 : 0,
                  child: Container(
                    width: widget.width / 3,
                    height: widget.width / 3,
                    decoration: BoxDecoration(
                        color: Colors.lightGreen[800], shape: BoxShape.circle),
                  ),
                ),
              )),
          Positioned(
            child: AnimatedScale(
              duration: duration_piece_scale,
              scale: widget.status == PieceStatus.selected ? 1.2 : 1.0,
              child: Container(
                child: piece,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
