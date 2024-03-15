class_name AddFoodPerSimilarTile
extends Effect

func resolve(args: EffectArgs):
	var maxCount: int = 0
	var colors: Dictionary = {}
	for t in args.adjacentTiles:
		if (t.placedStructure == null):
			continue
		var color = t.placedStructure.structure.get_color()
		if (!colors.has(color)):
			colors[color] = 1
		else:
			colors[color] += 1
		maxCount = max(colors[color], maxCount)
		
	args.gameState.food += maxCount

func rules_text() -> String:
	return "Add food per ="
