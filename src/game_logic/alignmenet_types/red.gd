class_name RedAlignment
extends Alignment

func get_color() -> Color:
	return Color.INDIAN_RED

func effects() -> Array[Effect]:
	return [AddFoodPerDifferentTile.new()]
