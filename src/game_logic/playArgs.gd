class_name PlayArgs
extends Resource

var gameState: GameState
var structure: Structure
var affectedTiles: Array[Tile] = []
var adjacentTiles: Array[Tile] = []

func _init(inputGameState: GameState, inputStructure: Structure, inputAffectedTiles: Array[Tile], inputAdjacentTiles: Array[Tile]) -> void:
	gameState = inputGameState
	structure = inputStructure
	affectedTiles = inputAffectedTiles
	adjacentTiles = inputAdjacentTiles
