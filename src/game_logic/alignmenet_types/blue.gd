class_name BlueAlignment
extends Alignment

func get_color() -> Color:
	return Color.CADET_BLUE

func placement_effects() -> Array[Effect]:
	return [DrawCard.new()]
