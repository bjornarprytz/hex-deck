class_name FreeSpaceRule
extends PlacementRule

func check(args: PlayEffectArgs) -> String:
	if (args.affectedTiles.size() < args.rotatedStructure.cells.size()):
		return "Part of the structure is outside map"
	
	for tile in args.affectedTiles:
		if tile.placedStructure != null:
			return "Tile already contains a structure"
	return ""
