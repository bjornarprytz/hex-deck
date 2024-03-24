class_name AdjacentAffinityRule
extends PlacementRule

var terrainType: TileInfo.TerrainType

func _init(terrain: TileInfo.TerrainType) -> void:
	terrainType = terrain

func check(args: PlayEffectArgs) -> String:
	for tile in args.adjacentTiles:
		if tile.type == terrainType:
			return ""
	return rules_text()

func rules_text():
	return "Requires adjacent %s" % [TileInfo.TerrainType.keys()[terrainType]]

func keyword():
	return "Affinity: %s" % [TileInfo.TerrainType.keys()[terrainType]]