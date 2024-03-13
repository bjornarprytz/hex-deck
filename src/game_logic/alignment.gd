class_name Alignment
extends Resource

func get_color() -> Color:
	push_error("get_color() should be overridden")
	return Color.DEEP_PINK

func get_rules() -> RulesHooks:
	push_error("get_rules() should be overridden")
	return null
