class_name AdjacentAffinityRule
extends PlacementRule

var terrainType: Tile.TerrainType

func _init(terrain: Tile.TerrainType) -> void:
	terrainType = terrain

func check(args: PlayEffectArgs) -> String:
	for tile in args.adjacentTiles:
		if tile.type == terrainType:
			return ""
	return rules_text()

func rules_text():
	return "Requires adjacent %s" % [Tile.TerrainType.keys()[terrainType]]
