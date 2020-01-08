import QtQuick 2.0
import QtQuick.Controls 2.14
import "CodeTranslate.js" as CodeTranslate
import "ValidMoves.js" as ValidMoves

Rectangle {
    id: root

    property int code: 0
    property string gameMode: ""
    property bool whiteIsCheck: false
    property bool blackIsCheck: false
    signal squareClicked( string coords)

    width: 60
    height: width
    color: {
        if (((code == 6) && whiteIsCheck) || ((code == -6) && blackIsCheck)) {
            return "red"
        }

        // row = Math.floor(index / 8)
        // row % 2 --> 0 or 1, add index and % 2 --> alternating pattern
        return (((Math.floor(index / 8)) %2) + index) % 2 == 0 ? "white" : "grey"
    }
    border.color: "lightblue"
    border.width: 0

    Text {
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: CodeTranslate.translateSquareCodeToUnicode(parent.code)
        font.family: "Helvetica"
        font.pointSize: 56
        color: "black"
    }

    MouseArea {
        id: myMouseArea
        anchors.fill: parent
        onClicked: {
            root.squareClicked(CodeTranslate.getChessCoords(index))
        }
        hoverEnabled: true
        onEntered: {
            if (myGameMode === "WaitingOnHuman" && ValidMoves.isValidSourceField(CodeTranslate.getChessCoords(index)) ) {
                root.border.width = 4
            }
            if ( myGameMode === "MoveSourcePicked" && ValidMoves.isValidTargetField(CodeTranslate.getChessCoords(index)) ) {
                root.border.width = 4
            }

        }
        onExited: {
            root.border.width = 0
        }
    }

}
