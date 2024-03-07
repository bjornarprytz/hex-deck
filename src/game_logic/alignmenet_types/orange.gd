class_name OrangeAlignment
extends Alignment

func get_color() -> Color:
	return Color.DARK_ORANGE

func resolve(_gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	pass
func validate_placement(_affectedTiles: Array[Tile], adjacentTiles: Array[Tile]) -> bool:
	for tile in adjacentTiles:
		if tile.structure == null and tile.type == Tile.TerrainType.Water:
			return true
	return false
