class_name Move
extends Effect

var path: Array[Vector2i] = [Utils.axialForward]

func _init(inputPath: Array[Vector2i]=[Utils.axialForward]) -> void:
	path = inputPath

func resolve(args: EffectArgs):
	var placedStructure = args.placedStructure
	var facing = placedStructure.state.facing
	var rotatedPath = Utils.get_rotated_cells(path, facing)
	
	placedStructure.move_along_path(rotatedPath)

func rules_text() -> String:
	return "Move"
