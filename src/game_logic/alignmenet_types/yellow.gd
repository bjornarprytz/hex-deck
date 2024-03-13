class_name YellowAlignment
extends Alignment

func get_color() -> Color:
	return Color.YELLOW

func get_id() -> Alignment.Id:
	return Alignment.Id.Yellow

func get_rules() -> RulesHooks:
	return RulesHooks.new().with_income_effects([AddFoodPerSimilarTile.new()])
