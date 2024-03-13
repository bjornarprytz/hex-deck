class_name Move
extends Effect

var path: Array[Vector2i]

## TODO: Figure out the specifics:
# In addition to the path, there needs to be a direction, and the path can be rotated to match it
# There's also obstructions to consider

func resolve(args: PlayArgs):
    var facing = args.structure.state.facing

    var rotatedPath = Utils.rotate_path(path, facing)

    var movedStructure = args.structure

    for step in rotatedPath:
        movedStructure = movedStructure.get_moved(step)
        # TODO: Check for obstructions
        # TODO: Visualize the movement
    
    args.structure.cells = movedStructure.cells # TODO: Check if it is safe to just assign the cells like this

func rules_text() -> String:
    return "Discover a tile"