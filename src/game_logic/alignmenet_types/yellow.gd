class_name YellowAlignment
extends Alignment

func get_color() -> Color:
	return Color.YELLOW

func effects() -> Array[Effect]:
	return [AddFoodPerSimilarTile.new()]
