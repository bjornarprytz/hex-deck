class_name RedAlignment
extends Alignment

func get_color() -> Color:
	return Color.INDIAN_RED

func income_effects() -> Array[Effect]:
	return [AddFoodPerDifferentTile.new()]
