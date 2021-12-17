import 'package:six_chess/data/Position.dart';

class PieceData {
  Point point;
  PieceID id;

  PieceType type;
  Point origin;

  PieceData(this.point, this.id)
      : type = id.toString().split("_")[1] == "a" ? PieceType.a : PieceType.b,
        origin = Point(int.parse(id.toString().split("_")[2].toString()) ~/ 10,
            int.parse(id.toString().split("_")[2].toString()) % 10);
}

var pieces = PieceID.values.map((id) => PieceData(point, id))
enum PieceType { a, b }

enum PieceID {
  p_a_00,
  p_a_01,
  p_a_02,
  p_a_03,
  p_a_10,
  p_a_13,
  //
  p_b_40,
  p_b_41,
  p_b_42,
  p_b_43,
  p_b_30,
  p_b_33,
}
