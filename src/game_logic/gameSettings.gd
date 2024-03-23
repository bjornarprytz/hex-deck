class_name GameSettings
extends Resource

var randomSeed: int = randi()

var _terrainTypePool: Dictionary = {
	TileInfo.TerrainType.Basic: 32,
	TileInfo.TerrainType.Water: 4,
	TileInfo.TerrainType.Mountain: 4
}

var mapRadius: int = 4
var foodRequirement: int = 25
var totalTurns: int = 5
var baseGoldIncome: int = 3
var baseHandSize: int = 5

func get_terrain_pool() -> Dictionary:
	return _terrainTypePool.duplicate()

func set_terrain_pool(basic: int=32, water: int=4, mountain: int=4) -> void:
	_terrainTypePool[TileInfo.TerrainType.Water] = water
	_terrainTypePool[TileInfo.TerrainType.Mountain] = mountain
	_terrainTypePool[TileInfo.TerrainType.Basic] = basic
