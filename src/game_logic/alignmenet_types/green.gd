class_name GreenAlignment
extends Alignment

func get_color() -> Color:
	return Color.FOREST_GREEN

func income_effects() -> Array[Effect]:
	return [AddFood.new()]
