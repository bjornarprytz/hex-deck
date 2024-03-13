class_name PurpleAlignment
extends Alignment

func get_color() -> Color:
	return Color.MEDIUM_PURPLE

func get_rules() -> RulesHooks:
	var rules = RulesHooks.new()
	rules.incomeEffects.push_back(AddGold.new())
	return rules
