class_name PlayArgs
extends Resource

var gameState: GameState
var card: Card
var rotatedStructure: Structure
var affectedTiles: Array[Tile] = []
var adjacentTiles: Array[Tile] = []

func _init(inputGameState: GameState, cardToPlay: Card, targetTile: Tile, rotationSteps: int) -> void: # inputStructure: Structure, inputAffectedTiles: Array[Tile], inputAdjacentTiles: Array[Tile]) -> void:
	gameState = inputGameState
	card = cardToPlay

	rotatedStructure = cardToPlay.structure.get_rotated(rotationSteps)
	affectedTiles = rotatedStructure.get_affected_tiles(targetTile)
	adjacentTiles = rotatedStructure.get_adjacent_tiles(targetTile)
