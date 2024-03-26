class_name FoodForVarietyInCardPile
extends CardPileEffect

func resolve(args: CardPileEffectArgs):
	var unique_alignments: Array[Alignment.Id] = []
	for card in args.cards:
		var alignment = card.alignment
		if !unique_alignments.has(alignment):
			unique_alignments.push_back(alignment)
	
	args.gameState.add_food(unique_alignments.size())

func rules_text():
	return "Gain 1 food per unique alignment among the cards."

func keyword():
	return "Food Variety"
