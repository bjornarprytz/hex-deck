class_name DiscoverTile
extends GameEffect

func resolve(args: GameEffectArgs):
	var map = args.gameState.map
	var newTileCoords = map.undiscoveredTiles.values().pick_random()
	var _newTile = map.discover_tile(newTileCoords)
	# TODO: Do something with _newTile?

func rules_text() -> String:
	return "DiscoverTile a tile"
