class_name PurpleAlignment
extends Alignment

func get_color() -> Color:
	return Color.MEDIUM_PURPLE

func effects() -> Array[Effect]:
	return [AddGold.new()]
