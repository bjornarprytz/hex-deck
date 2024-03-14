class_name Move
extends Effect

var path: Array[Vector2i] = [Utils.axialForward]

## TODO: Figure out the specifics:
# There's also obstructions to consider

func resolve(args: EffectArgs):
	var placedStructure = args.structure
	var facing = placedStructure.state.facing

	var rotatedPath = Utils.get_rotated_cells(path, facing)

	var movedStructure = placedStructure

	for step in rotatedPath:
		movedStructure = movedStructure.get_moved(step)
		# TODO: Check for obstructions
		# TODO: Visualize the movement
	
	args.structure.cells = movedStructure.cells # TODO: Check if it is safe to just assign the cells like this

	# TODO: Update the tiles

func rules_text() -> String:
	return "Move"
