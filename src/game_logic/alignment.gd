class_name Alignment
extends Resource

func get_color() -> Color:
	push_error("get_color() should be overridden")
	return Color.DEEP_PINK

func resolve(_gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	push_error("resolve() should be overridden")
func validate_placement(_affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]) -> bool:
	return true
