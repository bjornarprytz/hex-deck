class_name BlueAlignment
extends Alignment

func get_color() -> Color:
	return Color.CADET_BLUE

func resolve(gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	gameState.draw_card()
