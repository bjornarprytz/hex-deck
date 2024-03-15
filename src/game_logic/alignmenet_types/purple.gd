class_name PurpleAlignment
extends Alignment

func get_color() -> Color:
	return Color.MEDIUM_PURPLE

func get_id() -> Alignment.Id:
	return Alignment.Id.Purple

func get_rules() -> RulesHooks:
	return RulesHooks.new() \
		.with_income_effects([AddGold.new()])
