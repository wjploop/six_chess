class Point {
  final int y, x;

  Point(this.y, this.x);

  @override
  bool operator ==(Object other) {
    if (other is Point) {
      return other.y == y && other.x == x;
    }
    return false;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
