class_name GreenAlignment
extends Alignment

func get_color() -> Color:
	return Color.FOREST_GREEN

func get_id() -> Alignment.Id:
	return Alignment.Id.Green

func get_rules() -> RulesHooks:
	return RulesHooks.new() # Add alignment rules here
