class_name TakeAllPlacementBonuses
extends SubMission

var remainingPlacementBonuses: Array[Tile] = []
var _gameState: GameState

func _init(rewardEffect: Effect) -> void:
	super._init(rewardEffect)

func description() -> String:
	return "Take all placement bonuses"

func start(gameState: GameState):
	_gameState = gameState
	var map = gameState.map

	for tile in map.get_tiles():
		if tile.has_placement_bonus():
			remainingPlacementBonuses.append(tile)

	goal = remainingPlacementBonuses.size()

	for placedStructure in map.get_placed_structures():
		for tile in placedStructure.get_adjacent_tiles():
			if tile in remainingPlacementBonuses:
				remainingPlacementBonuses.erase(tile)

	currentProgress = goal - remainingPlacementBonuses.size()

	Events.onStructurePlaced.connect(_check_progress)

func _check_progress(placementArgs: PlacementEffectArgs) -> void:
	var progressBefore = currentProgress

	for tile in placementArgs.affectedTiles:
		if tile in remainingPlacementBonuses:
			remainingPlacementBonuses.erase(tile)
			currentProgress += 1

	if currentProgress != progressBefore:
		progress.emit(currentProgress, goal)
	if currentProgress == goal:
		await reward.resolve(placementArgs)
		completed.emit()
