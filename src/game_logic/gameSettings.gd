class_name GameSettings
extends Resource

var randomSeed: int = randi()

var terrainTypePool: Dictionary = {
	TileInfo.TerrainType.Basic: 32,
	TileInfo.TerrainType.Water: 4,
	TileInfo.TerrainType.Mountain: 4
}

var mapRadius: int = 4
var foodRequirement: int = 25
var totalTurns: int = 5
var baseGoldIncome: int = 3
var baseHandSize: int = 5
