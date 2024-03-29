class_name PayGold
extends Effect

var amount: int

func _init(inputAmount: int=1):
	assert(inputAmount > 0)
	amount = inputAmount

func resolve(args: PlacementEffectArgs):

	if (args.gameState.gold < amount):
		args.gameState.state.send_event("game over")
	args.gameState.remove_gold(amount)

func rules_text() -> String:
	return "Pay %d Gold" % amount

func keyword() -> String:
	return "Pay %d Gold" % amount
