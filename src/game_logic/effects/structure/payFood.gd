class_name PayFood
extends Effect

var amount: int

func _init(inputAmount: int=1):
	amount = inputAmount

func resolve(args: StructureEffectArgs):
	assert(amount > 0)

	if (args.gameState.food < amount):
		args.gameState.state.send_event("game over")
	args.gameState.remove_food(amount, args.affectedTiles)

func rules_text() -> String:
	return "Pay %d food" % amount
