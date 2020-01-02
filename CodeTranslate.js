.pragma library

const myCodeMap = new Map()
myCodeMap.set(0, "") // empty
myCodeMap.set(1, '\u2659') // White Pawn
myCodeMap.set(2, "\u2658")  // White Knight
myCodeMap.set(3, "\u2657")  // White Bishop
myCodeMap.set(4, "\u2656")  // White Rook
myCodeMap.set(5, "\u2655")  // White Queen
myCodeMap.set(6, "\u2654")  // White King
myCodeMap.set(-1, "\u265F") // Black Pawn
myCodeMap.set(-2, "\u265E") // Black Knight
myCodeMap.set(-3, "\u265D") // Black Bishop
myCodeMap.set(-4, "\u265C") // Black Rook
myCodeMap.set(-5, "\u265B") // Black Queen
myCodeMap.set(-6, "\u265A") // Black King
myCodeMap.set(99, "\u2612") // INVALID

function translateSquareCodeToUnicode(code) {
    return myCodeMap.get(code)
}

function getChessCoords(index) {
    const rowFromTop = Math.floor(index / 8)  // 0..7
    const row = 8 - rowFromTop  // 8..1
    const col = index % 8 // 0..7
    const colChar = String.fromCharCode(97 + col) // a..h
    return colChar + row // e.g. e2
}
