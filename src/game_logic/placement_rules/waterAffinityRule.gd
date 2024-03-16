class_name WaterAffinityRule
extends PlacementRule

func check(args: PlayEffectArgs) -> String:
	for tile in args.adjacentTiles:
		if tile.placedStructure == null and tile.type == Tile.TerrainType.Water:
			return ""
	return "Structure must be placed next to water"

func rules_text():
	return "Requires water"
