class_name RedAlignment
extends Alignment

func get_color() -> Color:
	return Color.INDIAN_RED

func get_rules() -> RulesHooks:
	var rules = RulesHooks.new()
	rules.incomeEffects.push_back(AddFoodPerDifferentTile.new())
	return rules
