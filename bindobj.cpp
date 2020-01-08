#include "bindobj.h"
#include <iostream>
#include "stdlib.h"
#include <sstream>
#include <thread>

BindObj::BindObj(QObject *parent) : QObject(parent), ai(board)
{
    srand(time(0)); // Seed the random number generator.c++
}



QVariantList BindObj::getBoardArray()
{
    int chessBoard[64];
    board.getBoardArray(chessBoard);
    QVariantList list;
    for ( size_t i = 0; i < 64; ++i ) {
        list << chessBoard[i];
    }

    return list;
}

QVariantList BindObj::askForMoves()
{
    CMoveList moves;
    board.find_legal_moves(moves);
    QVariantList list;
    for ( auto move : moves.m_moveList ) {
        list << QString::fromStdString(move.ToShortString());
    }
    return list;
}

bool BindObj::makeMove(QString msg)
{
    CMove move;
    if ( move.FromString(msg.toStdString().c_str()) == NULL ) {
        qDebug() << "Move " << msg << " doesn't parse properly";
        return false;
    }
    if ( ! board.IsMoveValid(move) ) {
        qDebug() << "The move " << msg << " is not a valid move";
        return false;
    }
    board.make_move(move);
    bool check = board.isOtherKingInCheck();
    board.undo_move(move);
    if (check)
    {
        std::cout << "You are in CHECK. Play another move." << std::endl;
        return false;
    }
    board.make_move(move);
    emit boardChanged();
    return true;
}

void BindObj::playComputerInThread()
{
    CMove best_move = ai.find_best_move();
    std::cout << "bestmove " << best_move << std::endl;
    board.make_move(best_move);
    emit boardChanged();
}
void BindObj::playComputer()
{
    std::thread t(&BindObj::playComputerInThread, this);
    t.detach();
}

bool BindObj::whiteIsCheck()
{
    return board.whiteKingInCheck();
}

bool BindObj::blackIsCheck()
{
    return board.blackKingInCheck();
}
