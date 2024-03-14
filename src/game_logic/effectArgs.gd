class_name EffectArgs
extends Resource

var gameState: GameState
var placedStructure: PlacedStructure
var affectedTiles: Array[Tile] = []
var adjacentTiles: Array[Tile] = []

func _init(inputGameState: GameState, inputStructure: PlacedStructure) -> void:
	gameState = inputGameState
	placedStructure = inputStructure
	affectedTiles = inputStructure.affectedTiles
	adjacentTiles = inputStructure.get_adjacent_tiles()
