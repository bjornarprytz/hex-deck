class_name AdjacentStructureRule
extends PlacementRule

func check(args: PlayArgs) -> String:
	# First tile must be on the border
	if args.gameState.map.structures.get_child_count() == 0:
		for tile in args.affectedTiles:
			if tile.get_neighbours().size() < 6:
				return ""
		return "First structure must be placed on border"
	else:
		for tile in args.adjacentTiles:
			if tile.structure != null:
				return ""
		return "Structure needs to be placed next to another structure"
