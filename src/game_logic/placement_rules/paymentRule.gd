class_name PaymentRule
extends PlacementRule

func check(args: PlayArgs) -> String:
	# First tile must be on the border
	var cost = args.card.cost
	if Meta.gold < cost.gold or args.gameState.food < cost.food:
		return "Insufficient resources"
	
	return ""
