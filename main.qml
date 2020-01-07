import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import "ValidMoves.js" as ValidMoves

Window {
    id: root
    visible: true
    width: 480
    height: 540
    title: qsTr("Richi's Chess")

    property string myGameMode: "WaitingOnHuman"
    property string moveSource: ""
    property string moveTarget: ""

    ListModel {
        id: chessBoard
        Component.onCompleted: {
            for (var i = 0; i < 64; i++) {
                append( {chessCode: 0} );
            }
            getBoard()
            ValidMoves.validMoves = bindObject.askForMoves();
        }
    }

    function getBoard() {
        var resp = bindObject.getBoardArray();
        for (var i=0; i<resp.length; i++) {
            chessBoard.set(i, { "chessCode": resp[i] });
        }
    }

    function playMove() {
        const moved = bindObject.makeMove(moveSource+moveTarget);
        if ( moved ) {
            myGameMode = "computerToPlay"
        } else {
            myGameMode = "WaitingOnHuman"
        }
        root.getBoard()
        moveSource = "";
        moveTarget = "";
    }

    function playComputer() {
        bindObject.playComputer();
        root.getBoard()
        ValidMoves.validMoves = bindObject.askForMoves();
        myGameMode = "WaitingOnHuman"
    }


    Connections {
            target: bindObject

            onBoardChanged: {
                console.log("Board Changed!");
                getBoard();
            }
    }

    Column {
        Component {
            id: squareDelegate
            Square{
                code: chessCode
                onSquareClicked: {
                    if ( myGameMode == "WaitingOnHuman" ) {
                        myGameMode = "MoveSourcePicked"
                        moveSource = coords
                        ValidMoves.pickedSource = coords
                    } else if ( myGameMode == "MoveSourcePicked" ) {
                        myGameMode = "MoveTargetPicked"
                        moveTarget = coords
                        root.playMove()
                        if (myGameMode === "computerToPlay") {
                            root.playComputer()
                        }
                    }
                }
                gameMode: root.myGameMode
            }
        }

        Grid {
            id: my_grid
            columns: 8
            Repeater {
                id: my_repeater
                model: chessBoard
                delegate: squareDelegate
            }
        }

        Row {
            TextField {
                text: moveSource
                placeholderText: qsTr("Source")
                width: 60
            }
            TextField {
                text: moveTarget
                placeholderText: qsTr("Target")
                width: 60
            }
            Text {
                text: "Status: " + myGameMode
            }
        }
    }



}
