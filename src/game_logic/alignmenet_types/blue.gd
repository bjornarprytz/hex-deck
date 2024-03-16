class_name BlueAlignment
extends Alignment

func get_color() -> Color:
	return Color.CADET_BLUE

func get_id() -> Alignment.Id:
	return Alignment.Id.Blue

func get_rules() -> RulesHooks:
	return RulesHooks.new() \
		.with_placement_rules([WaterAffinityRule.new()]) \
		.with_placement_effects([DrawCards.new()])
