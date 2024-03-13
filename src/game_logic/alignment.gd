class_name Alignment
extends Resource

func get_color() -> Color:
	push_error("get_color() should be overridden")
	return Color.DEEP_PINK
