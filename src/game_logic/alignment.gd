class_name Alignment
extends Resource

func get_color() -> Color:
	push_error("get_color() should be overridden")
	return Color.DEEP_PINK

func resolve(_gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	push_error("resolve() should be overridden")

func placement_rule() -> PlacementRule:
	return UnitRule.new()

func income(_gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	pass

func ongoing():
	# E.g. triggers, modify actions etc.
	pass

func rules_text():
	push_error("rules_text() should be overridden")
