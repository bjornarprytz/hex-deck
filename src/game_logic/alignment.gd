class_name Alignment
extends Resource

var _rulesText: String = ""

func get_color() -> Color:
	push_error("get_color() should be overridden")
	return Color.DEEP_PINK

func placement_effects() -> Array[Effect]:
	return []

func placement_rule() -> PlacementRule:
	return UnitRule.new()

func income_effects() -> Array[Effect]:
	return []

func ongoing():
	# E.g. triggers, modify actions etc.
	pass

func rules_text() -> String:
	var placementText = ""
	var incomeText = ""

	if (_rulesText == ""):
		for effect in placement_effects():
			var text = effect.rules_text()
			if placementText == "":
				placementText = "Immediate: %s" % [text]
			else:
				placementText = "%s %s" % [placementText, text]
		
		for effect in income_effects():
			var text = effect.rules_text()
			if incomeText == "":
				incomeText = "Income: %s" % [text]
			else:
				incomeText = "%s %s" % [incomeText, text]
	
	for part in [placementText, incomeText]:
		if part != "":
			if _rulesText != "":
				_rulesText += "\n"

			_rulesText = "%s%s" % [_rulesText, part]

	return _rulesText
