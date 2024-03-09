class_name FreeSpaceRule
extends PlacementRule

func check(args: PlacementArgs) -> String:
    if (args.affectedTiles.size() < args.structure.cells.size()):
        return "Part of the structure is outside map"
	
    for tile in args.affectedTiles:
        if tile.structure != null:
            return "Tile already contains a structure"
    return ""