class_name AddFood
extends Effect

var amount: int

func _init(inputAmount: int=1):
	assert(inputAmount > 0)
	amount = inputAmount

func resolve(args: PlacementEffectArgs):
	args.gameState.add_food(amount)

func rules_text() -> String:
	return "Add %d food" % amount

func keyword() -> String:
	return "Food %d" % amount
