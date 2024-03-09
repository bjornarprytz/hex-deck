class_name Alignment
extends Resource

var _rulesText: String = ""

func get_color() -> Color:
	push_error("get_color() should be overridden")
	return Color.DEEP_PINK

func effects() -> Array[Effect]:
	return []

func placement_rule() -> PlacementRule:
	return UnitRule.new()

func income(_gameState: GameState, _affectedTiles: Array[Tile], _adjacentTiles: Array[Tile]):
	pass

func ongoing():
	# E.g. triggers, modify actions etc.
	pass

func rules_text() -> String:
	if (_rulesText == ""):
		for effect in effects():
			var text = effect.rules_text()
			if _rulesText == "":
				_rulesText = text
			else:
				_rulesText = "%s %s" % [_rulesText, text]

	return _rulesText
