class_name PaymentRule
extends PlacementRule

func check(args: PlayEffectArgs) -> String:
	# First tile must be on the border
	var cost = args.card.cost
	if args.gameState.gold < cost.gold or args.gameState.food < cost.food:
		return "Insufficient resources"
	
	return ""
