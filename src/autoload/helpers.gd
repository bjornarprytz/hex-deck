class_name Utils

static func get_axial_neighbors(vector: Vector2i) -> Array[Vector2i]:
	return [
		vector + Vector2i(1,0),
		vector + Vector2i(1,-1),
		vector + Vector2i(0,-1),
		vector + Vector2i(-1,0),
		vector + Vector2i(-1,1),
		vector + Vector2i(0,1),
	]
