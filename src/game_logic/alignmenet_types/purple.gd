class_name PurpleAlignment
extends Alignment

func get_color() -> Color:
	return Color.MEDIUM_PURPLE

func income_effects() -> Array[Effect]:
	return [AddGold.new()]
