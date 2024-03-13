class_name GreenAlignment
extends Alignment

func get_color() -> Color:
	return Color.FOREST_GREEN

func get_rules() -> RulesHooks:
	var rules = RulesHooks.new()
	rules.incomeEffects.push_back(AddFood.new())
	return rules
