class_name CoverAllCorners
extends SubMission

var cornerTiles: Array[Tile] = []
var _gameState: GameState

func _init(rewardEffect: Effect) -> void:
    super._init(rewardEffect)

func description() -> String:
    return "Cover all corners"

func start(gameState: GameState):
    _gameState = gameState
    var map = gameState.map

    for tile in map.get_tiles():
        if tile.type == TileInfo.TerrainType.Basic and Utils.is_corner_tile(tile, map.radius):
            cornerTiles.append(tile)

    goal = cornerTiles.size()

    for placedStructure in map.get_placed_structures():
        for tile in placedStructure.get_adjacent_tiles():
            if tile in cornerTiles:
                cornerTiles.erase(tile)

    currentProgress = goal - cornerTiles.size()

    Events.onStructurePlaced.connect(_check_progress)

func _check_progress(placementArgs: PlacementEffectArgs) -> void:
    var progressBefore = currentProgress

    for tile in placementArgs.affectedTiles:
        if tile in cornerTiles:
            cornerTiles.erase(tile)
            currentProgress += 1

    if currentProgress != progressBefore:
        progress.emit(currentProgress, goal)
    if currentProgress == goal:
        await reward.resolve(placementArgs)
        completed.emit()