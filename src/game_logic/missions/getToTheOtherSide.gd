class_name GetToTheOtherSide
extends Mission

var _targetTiles: Array[Tile] = []
var _gameState: GameState

func _init(rewardEffect: Effect) -> void:
	super._init(rewardEffect)

func description() -> String:
	return "Get to the other side of the map"

func start(gameState: GameState):
	_gameState = gameState

	Events.onStructurePlaced.connect(_check_progress)

func _check_progress(placementArgs: PlacementEffectArgs) -> void:
	## First time we are called, we need to find the target tiles
	## Get the opposite tiles of the placed structure, and
	if _targetTiles.size() == 0:
		for tile in placementArgs.affectedTiles:
			var mirroredTile = tile.get_rotated_tile(3)
			var visited: Array[Tile] = []
			var queue: Array[Tile] = []
			while mirroredTile.type != TileInfo.TerrainType.Basic:
				visited.append(mirroredTile)
				for neighbor in mirroredTile.get_neighbours():
					if neighbor not in visited \
						and neighbor not in queue \
						and neighbor not in _targetTiles \
						and neighbor not in placementArgs.affectedTiles \
						and neighbor.is_edge():
						queue.append(neighbor)
				mirroredTile = queue.pop_front()
			_targetTiles.append(mirroredTile)
			mirroredTile.is_mission_target = true
		
		goal = _targetTiles.size()

	var progression = 0
	for tile in placementArgs.affectedTiles:
		if tile in _targetTiles:
			progression += 1
	currentProgress += progression

	if progression > 0:
		progress.emit(currentProgress, goal)
	if currentProgress == goal:
		await reward.resolve(placementArgs)
		completed.emit()
