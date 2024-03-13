class_name OrangeAlignment
extends Alignment

func get_color() -> Color:
	return Color.DARK_ORANGE

func get_rules() -> RulesHooks:
	var rules = RulesHooks.new()
	rules.placementRules.push_back(WaterAffinityRule.new())
	rules._rulesText = "Requires water"
	return rules
