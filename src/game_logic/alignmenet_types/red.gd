class_name RedAlignment
extends Alignment

func get_color() -> Color:
	return Color.INDIAN_RED

func get_id() -> Alignment.Id:
	return Alignment.Id.Red

func get_rules() -> RulesHooks:
	return RulesHooks.new().with_income_effects([AddFoodPerDifferentTile.new()])
