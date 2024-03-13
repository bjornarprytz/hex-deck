class_name Move
extends Effect

var path: Array[Vector2i]

## TODO: Figure out the specifics:
# There's also obstructions to consider

func resolve(args: PlayArgs):
	var facing = args.structure.state.facing

	var rotatedPath = Utils.get_rotated_cells(path, facing)

	var movedStructure = args.structure

	for step in rotatedPath:
		movedStructure = movedStructure.get_moved(step)
		# TODO: Check for obstructions
		# TODO: Visualize the movement
	
	args.structure.cells = movedStructure.cells # TODO: Check if it is safe to just assign the cells like this

func rules_text() -> String:
	return "DiscoverTile a tile"
