class_name Utils

static var axialForward: Vector2i = get_axial_neighbors()[0]

static func is_corner_tile(tile: Tile, mapRadius: int) -> bool:
	# TODO: This is a crude way to check if a tile is a corner. It should be improved.
	var cornerCoords = [0, (mapRadius - 1), - (mapRadius - 1)]
	var coords = tile.coordinates

	return coords.q != coords.r and coords.q in cornerCoords and coords.r in cornerCoords

static func is_edge_tile(tile: Tile, mapRadius: int) -> bool:
	var largestCardinal = mapRadius - 1
	var coords = tile.coordinates

	return abs(coords.q) == largestCardinal \
		or abs(coords.r) == largestCardinal \
		or abs(coords.s) == largestCardinal

static func get_axial_neighbors(vector: Vector2i=Vector2i.ZERO) -> Array[Vector2i]:
	return [
		vector + Vector2i(1, 0),
		vector + Vector2i(0, 1),
		vector + Vector2i( - 1, 1),
		vector + Vector2i( - 1, 0),
		vector + Vector2i(0, -1),
		vector + Vector2i(1, -1),
	]

static func get_path(steps: Array[int]) -> Array[Vector2i]:
	var path: Array[Vector2i] = []
	var currentPos := Vector2i.ZERO
	for stepDirection in steps:
		assert(stepDirection >= 0 and stepDirection < 6)
		currentPos = get_axial_neighbors(currentPos)[stepDirection]
		path.push_back(currentPos)
	
	return path

## Uses the axial coordinate system as described here: https://www.redblobgames.com/grids/hexagons/#coordinates-axial
static func get_cells(constellation: Array=[]) -> Array[Vector2i]:
	# Root (0,0) is given
	var cells: Array[Vector2i] = [Vector2i.ZERO]

	for tuple in constellation:
		var cell = Vector2i(tuple[0], tuple[1])
		assert(!cells.has(cell))

		cells.push_back(cell)

	return cells

static func get_rotated_cells(cells: Array[Vector2i], rotationSteps: int) -> Array[Vector2i]:
	var rotatedCells: Array[Vector2i] = []

	if ((rotationSteps % 6) == 0):
		return cells
	
	for cell in cells:
		var rotated = get_rotated_cell(cell, rotationSteps)
		rotatedCells.push_back(rotated)
	
	return rotatedCells

static func get_rotated_cell(vec: Vector2i, rotationSteps: int) -> Vector2i:
	var q = vec.x
	var r = vec.y
	var s = -q - r
	
	for rot in range(rotationSteps):
		var temp_q = q
		q = -r
		r = -s
		s = -temp_q
	
	return Vector2i(q, r)

static func get_polygon_points(vector: Vector2i=Vector2i(0, 0), nSides: int=6, radius: float=1.0) -> PackedVector2Array:
	var angle_increment = 2 * PI / nSides

	var center = axial_to_pixel(vector.x, vector.y, radius)

	var points: PackedVector2Array = []
	for i in range(nSides):
		var angle = i * angle_increment
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		
		points.push_back(center + Vector2(x, y))

	return points

static func axial_to_pixel(q: int, r: int, tileSize: float) -> Vector2:
	var x: float = tileSize * 3.0 / 2.0 * q
	var y: float = tileSize * sqrt(3) * (r + q / 2.0)
	return Vector2(x, y)

static func cube_round(frac: Map.Coordinates) -> Map.Coordinates:
	var q = round(frac.q)
	var r = round(frac.r)
	var s = round(frac.s)

	var q_diff = abs(q - frac.q)
	var r_diff = abs(r - frac.r)
	var s_diff = abs(s - frac.s)

	if q_diff > r_diff and q_diff > s_diff:
		q = -r - s
	elif r_diff > s_diff:
		r = -q - s
	else:
		s = -q - r

	return Map.Coordinates.new(q, r)

static func structure_size(s: int) -> Array[Vector2i]:
	return standardStructures[s - 1]

static var standardStructures: Array = [
	Utils.get_cells(),
	Utils.get_cells([[1, -1]]),
	Utils.get_cells([[1, -1], [1, 0]]),
	Utils.get_cells([[1, -1], [1, 0], [0, -1]]),
	Utils.get_cells([[1, -1], [1, 0], [0, -1], [0, 1]]),
]
