class_name Discover
extends Effect

func resolve(args: PlayArgs):
    var map = args.gameState.map
    var newTileCoords = map.undiscoveredTiles.pick_random()
    var _newTile = map.discover_tile(newTileCoords)
    # TODO: Do something with _newTile?

func rules_text() -> String:
    return "Discover a tile"
