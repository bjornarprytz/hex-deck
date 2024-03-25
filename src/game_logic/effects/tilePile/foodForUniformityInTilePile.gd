class_name FoodForUniformityInTilePile
extends TilePileEffect

func resolve(args: TilePileEffectArgs):
	var maxCount: int = 0
	var alignments: Dictionary = {}
	for t in args.tiles:
		if (!t.has_structure()):
			continue
		var alignment = t.placedStructure.structure.alignment
		if (!alignments.has(alignment)):
			alignments[alignment] = 1
		else:
			alignments[alignment] += 1
		maxCount = max(alignments[alignment], maxCount)

	args.gameState.add_food(maxCount)

func keyword() -> String:
	return "Food: Uniformity"
