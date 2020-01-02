.pragma library

var validMoves

function isValidSourceField(coord) {
    return validMoves.findIndex( e => e.substring(0,2) === (coord)) > -1;
}

var pickedSource

function isValidTargetField(coord) {
    const move = pickedSource + coord
    return validMoves.findIndex( e => e === move) > -1;
}
