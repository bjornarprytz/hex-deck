class_name RedAlignment
extends Alignment

func get_color() -> Color:
	return Color.INDIAN_RED

func resolve(gameState: GameState, _affectedTiles: Array[Tile], adjacentTiles: Array[Tile]):
	var unique_colors : Array[Color] = []
	for t in adjacentTiles:
		if (t.structure == null):
			continue
		var color = t.structure.alignment.get_color()
		if !unique_colors.has(color):
			unique_colors.push_back(color)
	gameState.score += unique_colors.size()
