class_name Structure
extends Resource

# This is a placeholder for a discrete type, like a color in magic
@export var color: Color

## Tuples (q,r) are stored as Vector2i here
@export var cells: Array[Vector2i]


func get_rotated(rotationSteps: int) -> Structure:
	while rotationSteps < 0:
		rotationSteps += 6
	rotationSteps = rotationSteps % 6
	
	var rotatedCells: Array[Vector2i] = []
	
	for cell in cells:
		var q = cell.x
		var r = cell.y
		var s = -q-r
		
		for rot in range(rotationSteps):
			var temp_q = q
			q = -r
			r = -s
			s = -temp_q
		
		rotatedCells.push_back(Vector2i(q, r))
	
	var rotatedStructure = Structure.new()
	rotatedStructure.color = color
	rotatedStructure.cells = rotatedCells
	
	return rotatedStructure
