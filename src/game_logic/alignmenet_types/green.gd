class_name GreenAlignment
extends Alignment

func get_color() -> Color:
	return Color.SEA_GREEN

func resolve(gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	gameState.score += 1
