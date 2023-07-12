import 'package:chess_game/piece.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool white;
  final Piece? piece;
  final bool isSelected;
  final bool isvalidmove;
  final void Function()? ontap;
  Square(
      {required this.white,
      required this.piece,
      required this.isSelected,
      required this.ontap,
      required this.isvalidmove});

  @override
  Widget build(BuildContext context) {
    Color? squarecolor;
    if (isSelected) {
      squarecolor = Color.fromARGB(255, 103, 198, 106);
    } else if (isvalidmove) {
      squarecolor = Color.fromARGB(255, 122, 231, 126);
    } else {
      squarecolor = white == true
          ? Color.fromARGB(255, 183, 183, 183)
          : Color.fromARGB(255, 119, 118, 118);
    }
    return GestureDetector(
      onTap: ontap,
      child: Container(
          color: squarecolor,
          child: piece != null
              ? Image.asset(
                  piece!.imagepath,
                  color: piece!.iswhite == true ? Colors.white : Colors.black,
                  scale: 13,
                )
              : null),
    );
  }
}
