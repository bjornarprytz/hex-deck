class_name ConnectEachRock
extends SubMission

var remainingRocks: Array[Tile] = []
var _gameState: GameState

func _init(rewardEffect: Effect) -> void:
	super._init(rewardEffect)

func description() -> String:
	return "Connect each rock"

func start(gameState: GameState):
	_gameState = gameState
	var map = gameState.map

	for tile in map.get_tiles():
		if tile.type == TileInfo.TerrainType.Mountain:
			remainingRocks.append(tile)

	goal = remainingRocks.size()

	for placedStructure in map.get_placed_structures():
		for tile in placedStructure.get_adjacent_tiles():
			if tile in remainingRocks:
				remainingRocks.erase(tile)

	currentProgress = goal - remainingRocks.size()

	Events.onStructurePlaced.connect(_check_progress)

func _check_progress(placementArgs: PlacementEffectArgs) -> void:
	var progressBefore = currentProgress

	for tile in placementArgs.adjacentTiles:
		if tile in remainingRocks:
			remainingRocks.erase(tile)
			currentProgress += 1

	if currentProgress != progressBefore:
		progress.emit(currentProgress, goal)
	if currentProgress == goal:
		await reward.resolve(placementArgs)
		completed.emit()
