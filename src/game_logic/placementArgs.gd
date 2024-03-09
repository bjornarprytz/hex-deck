class_name PlacementArgs
extends Resource

var gameState: GameState
var card: Card
var structure: Structure
var affectedTiles: Array[Tile] = []
var adjacentTiles: Array[Tile] = []

func _init(inputGameState: GameState, inputCard: Card, inputStructure: Structure, inputAffectedTiles: Array[Tile], inputAdjacentTiles: Array[Tile]) -> void:
	gameState = inputGameState
	card = inputCard
	structure = inputStructure
	affectedTiles = inputAffectedTiles
	adjacentTiles = inputAdjacentTiles
