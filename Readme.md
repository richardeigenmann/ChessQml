# ChessQml - An Exercise to create a Chess GUI in QML with a C++ game back-end

## Motivation

QML is a great descriptive language to create a user interface in. Through it's integration with
JavaScript it can already do pretty sophisticated things. I was looking for a use-case where one
might reasonably prefer to do the "heavy-lifting" in C++ which brought me to chess.

This project aims to show the ease with which the traditionally fiddly GUI can be built in QML
and how we can harness the performance of C++ to build a project.

C++ has a huge pool of existing code and luckily there are multiple chess engines already written.
For this project I picked mchess from Michael Jorgensen https://github.com/MJoergen/mchess which
he kindly contributes to the public to learn about writing a chess program.


## Script

* Start off by downloading Michael Jorgensen's mchess program. Compile it. Try it out.

```bash
git clone https://github.com/MJoergen/mchess.git
cd mchess
make

./mchess
```

* Look at the main.cc program

You will notice that the program interface is pretty straigt forward. Key are the chess board
`CBoard` and the `AI` engine.

```cpp
CBoard board;
AI ai(board);
```

Look at the `CBoard.h` program to see explanations about the board and the chess pieces. Michael explains
why extending the board beyond the 8x8 matrix is beneficial to the chess algorythm.

The entire API boils down to these methods:

```cpp
void newGame();
void find_legal_moves(CMoveList &moves) const;
void make_move(const CMove &move);
void undo_move(const CMove &move);
int  get_value();
bool IsMoveValid(CMove &move) const;
bool isKingInCheck() const;
bool isOtherKingInCheck() const;
friend std::ostream& operator <<(std::ostream &os, const CBoard &rhs);
```

* Create a QT QML Application with QT Creator

Open up the `qtcreator` program and create a new Project > Application > Qt Quick Application - Empty

* Create a Square

* Create a test Square

* Map the integer codes from the Chess Board to Square

```cpp
// Each element contains one of the following values:
//   0  :  Empty
//   1  :  White Pawn
//   2  :  White Knight
//   3  :  White Bishop
//   4  :  White Rook
//   5  :  White Queen
//   6  :  White King
//   -1 :  Black Pawn
//   -2 :  Black Knight
//   -3 :  Black Bishop
//   -4 :  Black Rook
//   -5 :  Black Queen
//   -6 :  Black King
//   99 :  INVALID
```

* In CMoveList.h move the std::vector from private to public

* Create the askForMoves method in the bind object


