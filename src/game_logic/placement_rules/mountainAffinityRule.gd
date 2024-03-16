class_name MountainAffinityRule
extends PlacementRule

func check(args: PlayEffectArgs) -> String:
	for tile in args.adjacentTiles:
		if tile.placedStructure == null and tile.type == Tile.TerrainType.Mountain:
			return ""
	return "Structure must be placed next to mountain"

func rules_text():
	return "Requires mountian"
