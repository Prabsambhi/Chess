enum Piecetype { pawn, rook, knight, bishop, queen, king }

class Piece {
  final Piecetype type;
  final bool iswhite;
  final String imagepath;

  Piece({required this.type, required this.iswhite, required this.imagepath});
}
