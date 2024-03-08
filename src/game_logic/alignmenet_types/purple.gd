class_name PurpleAlignment
extends Alignment

func get_color() -> Color:
	return Color.MEDIUM_PURPLE

func resolve(_gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	Meta.gold += 1

func rules_text():
	return "1 Gold"
