class_name TileInfo # TileData was taken
extends Resource

enum TerrainType {
	Basic,
	Water,
	Mountain
}

var terrainType: TerrainType
var placementBonus: PlacementBonus

func _init(type: TerrainType, bonus: PlacementBonus=null):
	terrainType = type
	placementBonus = bonus