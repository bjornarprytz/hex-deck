class_name PayCost
extends PlayEffect

func resolve(args: PlayEffectArgs):
	var cost = args.card.cost

	if cost.food > 0:
		args.gameState.remove_food(cost.food)
	if cost.gold > 0:
		args.gameState.remove_gold(cost.gold)
