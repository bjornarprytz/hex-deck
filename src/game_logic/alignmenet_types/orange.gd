class_name OrangeAlignment
extends Alignment

func get_color() -> Color:
	return Color.DARK_ORANGE

func get_id() -> Alignment.Id:
	return Alignment.Id.Orange

func get_rules() -> RulesHooks:
	return RulesHooks.new() # Add alignment rules here
