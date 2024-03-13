class_name Alignment
extends Resource

enum Id {
	Red,
	Yellow,
	Blue,
	Green,
	Orange,
	Purple,
}

func get_color() -> Color:
	push_error("get_color() should be overridden")
	return Color.DEEP_PINK

func get_rules() -> RulesHooks:
	return RulesHooks.new()

func get_id() -> Id:
	push_error("get_id() should be overridden")
	return Id.Red
