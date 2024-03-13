class_name BlueAlignment
extends Alignment

func get_color() -> Color:
	return Color.CADET_BLUE

func get_rules() -> RulesHooks:
	var rules = RulesHooks.new()
	rules.placementEffects.push_back(DrawCard.new())
	return rules
