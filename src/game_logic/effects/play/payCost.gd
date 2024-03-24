class_name PayCost
extends Effect

func resolve(args: PlayEffectArgs):
	var cost = args.card.cost

	if cost.food > 0:
		args.gameState.remove_food(cost.food)
	if cost.gold > 0:
		args.gameState.remove_gold(cost.gold)

func keyword() -> String:
	return "Pay"
