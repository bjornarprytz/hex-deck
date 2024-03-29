class_name PayFood
extends Effect

var amount: int

func _init(inputAmount: int=1):
	assert(inputAmount > 0)
	amount = inputAmount

func resolve(args: PlacementEffectArgs):

	if (args.gameState.food < amount):
		args.gameState.state.send_event("game over")
	args.gameState.remove_food(amount)

func rules_text() -> String:
	return "Pay %d Food" % amount

func keyword() -> String:
	return "Pay %d Food" % amount
