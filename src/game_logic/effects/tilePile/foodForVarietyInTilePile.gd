class_name FoodForVarietyInTilePile
extends TilePileEffect

func resolve(args: TilePileEffectArgs):
	var uniqueAlignments: Array[Alignment.Id] = []
	for t in args.tiles:
		if (!t.has_structure()):
			continue
		var alignment = t.placedStructure.structure.alignment
		if !uniqueAlignments.has(alignment):
			uniqueAlignments.push_back(alignment)

	args.gameState.add_food(uniqueAlignments.size())

func rules_text() -> String:
	return "Add food per different color in structures"

func keyword() -> String:
	return "Food: Variety"
