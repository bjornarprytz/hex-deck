class_name GreenAlignment
extends Alignment

func get_color() -> Color:
	return Color.FOREST_GREEN

func effects() -> Array[Effect]:
	return [AddFood.new()]
