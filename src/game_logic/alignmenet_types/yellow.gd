class_name YellowAlignment
extends Alignment

func get_color() -> Color:
	return Color.YELLOW

func resolve(gameState: GameState, _affectedTiles: Array[Tile], adjacentTiles: Array[Tile]):
	var maxCount : int = 0
	var colors : Dictionary = {}
	for t in adjacentTiles:
		if (t.structure == null):
			continue
		var color = t.structure.alignment.get_color()
		if (!colors.has(color)):
			colors[color] = 1
		else:
			colors[color] += 1
		maxCount = max(colors[color], maxCount)
		
	gameState.score += maxCount
