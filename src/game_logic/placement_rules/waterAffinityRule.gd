class_name WaterAffinityRule
extends PlacementRule

func check(args: PlayArgs) -> String:
	for tile in args.adjacentTiles:
		if tile.structure == null and tile.type == Tile.TerrainType.Water:
			return ""
	return "Structure must be placed next to water"
