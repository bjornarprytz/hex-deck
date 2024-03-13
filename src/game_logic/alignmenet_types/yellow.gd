class_name YellowAlignment
extends Alignment

func get_color() -> Color:
	return Color.YELLOW

func get_rules() -> RulesHooks:
	var rules = RulesHooks.new()
	rules.incomeEffects.push_back(AddFoodPerSimilarTile.new())
	return rules
