class_name TilePileEffectArgs
extends EffectArgs

var tiles: Array[Tile]

func _init(inputGameState: GameState, inputTiles: Array[Tile]) -> void:
	super._init(inputGameState)
	tiles = inputTiles