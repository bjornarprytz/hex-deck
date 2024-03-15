class_name AddFoodPerDifferentTile
extends Effect

func resolve(args: EffectArgs):
	var unique_colors: Array[Color] = []
	for t in args.adjacentTiles:
		if (t.placedStructure == null):
			continue
		var color = t.placedStructure.structure.get_color()
		if !unique_colors.has(color):
			unique_colors.push_back(color)
	
	args.gameState.add_food(unique_colors.size(), args.affectedTiles)

func rules_text() -> String:
	return "Add food per !="
