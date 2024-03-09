class_name OrangeAlignment
extends Alignment

func get_color() -> Color:
	return Color.DARK_ORANGE

func placement_rule() -> PlacementRule:
	return WaterAffinityRule.new()

func rules_text() -> String:
	return "Requires water"
