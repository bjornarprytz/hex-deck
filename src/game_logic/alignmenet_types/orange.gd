class_name OrangeAlignment
extends Alignment

func get_color() -> Color:
	return Color.DARK_ORANGE

func resolve(_gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	pass
func placement_rule() -> PlacementRule:
	return WaterAffinityRule.new()

func rules_text():
	return "Requires water"
