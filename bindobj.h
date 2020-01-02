#pragma once

#include <QObject>
#include <QDebug>
#include "CBoard.h"
#include "ai.h"

class BindObj : public QObject
{
    Q_OBJECT
public:
    explicit BindObj(QObject *parent = nullptr);
    CBoard board{};
    AI ai;

public slots:
    QVariantList getBoardArray();
    QVariantList askForMoves();
    bool makeMove(QString msg);
    void playComputer();
};


