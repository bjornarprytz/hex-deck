class_name ConnectEachWater
extends Mission

var remainingWater: Array[Tile] = []
var _gameState: GameState

func _init(rewardEffect: Effect) -> void:
	super._init(rewardEffect)

func description() -> String:
	return "Connect each water"

func start(gameState: GameState):
	_gameState = gameState
	var map = gameState.map

	for tile in map.get_tiles():
		if tile.type == TileInfo.TerrainType.Water:
			remainingWater.append(tile)
			tile.is_mission_target = true

	goal = remainingWater.size()

	for placedStructure in map.get_placed_structures():
		for tile in placedStructure.get_adjacent_tiles():
			if tile in remainingWater:
				remainingWater.erase(tile)

	currentProgress = goal - remainingWater.size()

	Events.onStructurePlaced.connect(_check_progress)

func _check_progress(placementArgs: PlacementEffectArgs) -> void:
	var progressBefore = currentProgress

	for tile in placementArgs.adjacentTiles:
		if tile in remainingWater:
			remainingWater.erase(tile)
			currentProgress += 1

	if currentProgress != progressBefore:
		progress.emit(currentProgress, goal)
	if currentProgress == goal:
		await reward.resolve(placementArgs)
		completed.emit()