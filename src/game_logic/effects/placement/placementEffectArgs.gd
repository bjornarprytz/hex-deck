class_name PlacementEffectArgs
extends EffectArgs

var placedStructure: PlacedStructure
var affectedTiles: Array[Tile] = []
var adjacentTiles: Array[Tile] = []

func _init(inputGameState: GameState, inputStructure: PlacedStructure) -> void:
	gameState = inputGameState
	if inputStructure != null:
		placedStructure = inputStructure
		affectedTiles = inputStructure.affectedTiles
		adjacentTiles = inputStructure.get_adjacent_tiles()
