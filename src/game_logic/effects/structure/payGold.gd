class_name PayGold
extends Effect

var amount: int

func _init(inputAmount: int=1):
	amount = inputAmount

func resolve(args: StructureEffectArgs):
	assert(amount > 0)

	if (args.gameState.gold < amount):
		args.gameState.state.send_event("game over")
	args.gameState.remove_gold(amount, args.affectedTiles)

func rules_text() -> String:
	return "Pay %d gold" % amount
