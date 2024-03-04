class_name Utils


static func alignment_to_color(alignment: Structure.Alignment) -> Color:
	match alignment:
		Structure.Alignment.Blue:
			return Color.CADET_BLUE
		Structure.Alignment.Yellow:
			return Color.YELLOW
		Structure.Alignment.Red:
			return Color.INDIAN_RED
		Structure.Alignment.Green:
			return Color.PALE_GREEN
		Structure.Alignment.Orange:
			return Color.CORAL
		Structure.Alignment.Purple:
			return Color.MEDIUM_PURPLE
	
	return Color.DARK_TURQUOISE

static func get_axial_neighbors(vector: Vector2i) -> Array[Vector2i]:
	return [
		vector + Vector2i(1,0),
		vector + Vector2i(1,-1),
		vector + Vector2i(0,-1),
		vector + Vector2i(-1,0),
		vector + Vector2i(-1,1),
		vector + Vector2i(0,1),
	]
