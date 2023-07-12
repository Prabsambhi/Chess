// ignore_for_file: prefer_const_constructors, unused_local_variable, unrelated_type_equality_checks

import 'package:chess_game/piece.dart';
import 'package:chess_game/square.dart';
import 'package:flutter/material.dart';

class Myboard extends StatefulWidget {
  const Myboard({Key? key}) : super(key: key);

  @override
  State<Myboard> createState() => _MyboardState();
}

class _MyboardState extends State<Myboard> {
  late List<List<Piece?>> board;
  int selectedrow = -1;
  int selectedcol = -1;
  Piece? Selectedpiece;
  List<List<int>> validmoves = [];

  @override
  void initState() {
    super.initState();
    initialiseboard();
  }

  void initialiseboard() {
    List<List<Piece?>> initialboard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    //Pawn
    // for (int i = 0; i < 8; i++) {
    //   initialboard[1][i] = Piece(
    //       type: Piecetype.pawn,
    //       iswhite: false,
    //       imagepath: "lib/Pieces/pawn.png");
    //   initialboard[6][i] = Piece(
    //       type: Piecetype.pawn,
    //       iswhite: true,
    //       imagepath: "lib/Pieces/pawn.png");
    // }

    // Rook
    initialboard[0][0] = Piece(
        type: Piecetype.rook, iswhite: false, imagepath: "lib/Pieces/rook.png");
    initialboard[0][7] = Piece(
        type: Piecetype.rook, iswhite: false, imagepath: "lib/Pieces/rook.png");
    initialboard[7][0] = Piece(
        type: Piecetype.rook, iswhite: true, imagepath: "lib/Pieces/rook.png");
    initialboard[7][7] = Piece(
        type: Piecetype.rook, iswhite: true, imagepath: "lib/Pieces/rook.png");
    // Knight
    initialboard[0][1] = Piece(
        type: Piecetype.knight,
        iswhite: false,
        imagepath: "lib/Pieces/knight.png");
    initialboard[0][6] = Piece(
        type: Piecetype.knight,
        iswhite: false,
        imagepath: "lib/Pieces/knight.png");
    initialboard[7][1] = Piece(
        type: Piecetype.knight,
        iswhite: true,
        imagepath: "lib/Pieces/knight.png");
    initialboard[7][6] = Piece(
        type: Piecetype.knight,
        iswhite: true,
        imagepath: "lib/Pieces/knight.png");

    // Bishop
    initialboard[0][2] = Piece(
        type: Piecetype.bishop,
        iswhite: false,
        imagepath: "lib/Pieces/bishop.png");
    initialboard[4][4] = Piece(
        type: Piecetype.bishop,
        iswhite: false,
        imagepath: "lib/Pieces/bishop.png");
    initialboard[4][5] = Piece(
        type: Piecetype.bishop,
        iswhite: true,
        imagepath: "lib/Pieces/bishop.png");
    initialboard[7][5] = Piece(
        type: Piecetype.bishop,
        iswhite: true,
        imagepath: "lib/Pieces/bishop.png");

    // Queen
    initialboard[0][3] = Piece(
        type: Piecetype.queen,
        iswhite: false,
        imagepath: "lib/Pieces/queen.png");
    initialboard[7][3] = Piece(
        type: Piecetype.queen,
        iswhite: true,
        imagepath: "lib/Pieces/queen.png");

    // King
    initialboard[0][4] = Piece(
        type: Piecetype.king, iswhite: false, imagepath: "lib/Pieces/king.png");
    initialboard[7][4] = Piece(
        type: Piecetype.king, iswhite: true, imagepath: "lib/Pieces/king.png");

    board = initialboard;
  }

  bool checkinsideboard(int row, int col) {
    if (row >= 0 && row <= 7 && col >= 0 && col <= 7) {
      return true;
    } else {
      return false;
    }
  }

  void checkSelected(int row, int col) {
    setState(() {
      if (board[row][col] != null) {
        Selectedpiece = board[row][col];
        selectedrow = row;
        selectedcol = col;
      }
      validmoves = Moves(row, col, Selectedpiece);
    });
  }

  List<List<int>> Moves(int row, int col, Piece? piece) {
    List<List<int>> candidatemoves = [];

    int direction = piece?.iswhite == true ? -1 : 1;
    switch (piece!.type) {
      case Piecetype.pawn:
        if (checkinsideboard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidatemoves.add([row + direction, col]);
        }
        if ((row == 1 && !piece.iswhite) || (row == 6 && piece.iswhite)) {
          if (checkinsideboard(row + 2 * direction, col) &&
              (board[row + 2 * direction][col]) == null) {
            candidatemoves.add([row + 2 * direction, col]);
          }
        }
        if (piece.iswhite &&
            checkinsideboard(row - 1, col + 1) &&
            board[row - 1][col + 1] != null &&
            board[row - 1][col + 1]?.iswhite == false) {
          candidatemoves.add([row - 1, col + 1]);
        }
        if (piece.iswhite &&
            checkinsideboard(row - 1, col - 1) &&
            board[row - 1][col - 1] != null &&
            board[row - 1][col - 1]?.iswhite == false) {
          candidatemoves.add([row - 1, col - 1]);
        }
        if (!piece.iswhite &&
            checkinsideboard(row + 1, col + 1) &&
            board[row + 1][col + 1] != null &&
            board[row + 1][col + 1]?.iswhite == true) {
          candidatemoves.add([row + 1, col + 1]);
        }
        if (!piece.iswhite &&
            checkinsideboard(row + 1, col - 1) &&
            board[row + 1][col - 1] != null &&
            board[row + 1][col - 1]?.iswhite == true) {
          candidatemoves.add([row + 1, col - 1]);
        }
        break;
      case Piecetype.rook:
        int x1 = col, x2 = col, y1 = row, y2 = row;
        while (x1 + 1 < 8 && board[row][x1 + 1] == null) {
          candidatemoves.add([row, x1 + 1]);
          x1++;
        }
        while (x2 - 1 >= 0 && board[row][x2 - 1] == null) {
          candidatemoves.add([row, x2 - 1]);
          x2--;
        }
        while (y1 - 1 >= 0 && board[y1 - 1][col] == null) {
          candidatemoves.add([y1 - 1, col]);
          y1--;
        }
        while (y2 + 1 < 8 && board[y2 + 1][col] == null) {
          candidatemoves.add([y2 + 1, col]);
          y2++;
        }

        break;
      case Piecetype.knight:
        if (checkinsideboard(row + 2, col - 1) &&
            (board[row + 2][col - 1] == null ||
                board[row + 2][col - 1]?.iswhite != piece.iswhite)) {
          candidatemoves.add([row + 2, col - 1]);
        }
        if (checkinsideboard(row - 2, col - 1) &&
            (board[row - 2][col - 1] == null ||
                board[row - 2][col - 1]?.iswhite != piece.iswhite)) {
          candidatemoves.add([row - 2, col - 1]);
        }
        if (checkinsideboard(row + 2, col + 1) &&
            (board[row + 2][col + 1] == null ||
                board[row + 2][col + 1]?.iswhite != piece.iswhite)) {
          candidatemoves.add([row + 2, col + 1]);
        }
        if (checkinsideboard(row - 2, col + 1) &&
            (board[row - 2][col + 1] == null ||
                board[row - 2][col + 1]?.iswhite != piece.iswhite)) {
          candidatemoves.add([row - 2, col + 1]);
        }
        if (checkinsideboard(row + 1, col - 2) &&
            (board[row + 1][col - 2] == null ||
                board[row + 1][col - 2]?.iswhite != piece.iswhite)) {
          candidatemoves.add([row + 1, col - 2]);
        }
        if (checkinsideboard(row + 1, col + 2) &&
            (board[row + 1][col + 2] == null ||
                board[row + 1][col + 2]?.iswhite != piece.iswhite)) {
          candidatemoves.add([row + 1, col + 2]);
        }
        if (checkinsideboard(row - 1, col - 2) &&
            (board[row - 1][col - 2] == null ||
                board[row - 1][col - 2]?.iswhite != piece.iswhite)) {
          candidatemoves.add([row - 1, col - 2]);
        }
        if (checkinsideboard(row - 1, col + 2) &&
            (board[row - 1][col + 2] == null ||
                board[row - 1][col + 2]?.iswhite != piece.iswhite)) {
          candidatemoves.add([row - 1, col + 2]);
        }
        break;
      case Piecetype.king:
        break;
      case Piecetype.queen:
        break;
      case Piecetype.bishop:
        int x1 = col,
            x2 = col,
            x3 = col,
            x4 = col,
            y1 = row,
            y2 = row,
            y3 = row,
            y4 = row;
        while (x1 + 1 < 8 &&
            y1 + 1 < 8 &&
            (board[y1 + 1][x1 + 1] == null ||
                board[y1 + 1][x1 + 1]?.iswhite != piece.iswhite)) {
          candidatemoves.add([y1 + 1, x1 + 1]);
          x1++;
          y1++;
        }
        while (x2 + 1 < 8 &&
            y2 - 1 >= 0 &&
            (board[y2 - 1][x2 + 1] == null ||
                board[y2 - 1][x2 + 1]?.iswhite != piece.iswhite)) {
          candidatemoves.add([y2 - 1, x2 + 1]);
          x2++;
          y2--;
        }
        while (y3 - 1 >= 0 &&
            x3 - 1 >= 0 &&
            (board[y3 - 1][x3 - 1] == null ||
                board[y3 - 1][x3 - 1]?.iswhite != piece.iswhite)) {
          candidatemoves.add([y3 - 1, x3 - 1]);
          y3--;
          x3--;
        }
        while (y4 + 1 < 8 &&
            x4 - 1 >= 0 &&
            (board[y4 + 1][x4 - 1] == null ||
                board[y4 - 1][x4 - 1]?.iswhite != piece.iswhite)) {
          candidatemoves.add([y4 + 1, x4 - 1]);
          y4++;
          x4--;
        }
        break;
    }

    return candidatemoves;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: 64,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          itemBuilder: (context, index) {
            int row = index ~/ 8, col = index % 8;

            bool isSelected = selectedrow == row && selectedcol == col;
            bool validmove = false;
            for (var pos in validmoves) {
              if (pos[0] == row && pos[1] == col) {
                validmove = true;
              }
            }

            if ((index ~/ 8) % 2 == 0) {
              if (index % 2 == 0) {
                return Square(
                    white: true,
                    piece: board[row][col],
                    isSelected: isSelected,
                    isvalidmove: validmove,
                    ontap: () => checkSelected(row, col));
              } else {
                return Square(
                    white: false,
                    piece: board[row][col],
                    isSelected: isSelected,
                    isvalidmove: validmove,
                    ontap: () => checkSelected(row, col));
              }
            } else {
              if (index % 2 != 0) {
                return Square(
                    white: true,
                    piece: board[row][col],
                    isSelected: isSelected,
                    isvalidmove: validmove,
                    ontap: () => checkSelected(row, col));
              } else {
                return Square(
                    white: false,
                    piece: board[row][col],
                    isSelected: isSelected,
                    isvalidmove: validmove,
                    ontap: () => checkSelected(row, col));
              }
            }
          }),
    );
  }
}
