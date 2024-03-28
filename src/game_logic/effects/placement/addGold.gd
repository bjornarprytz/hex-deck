class_name AddGold
extends Effect

var amount: int

func _init(inputAmount: int=1):
	assert(inputAmount > 0)
	amount = inputAmount

func resolve(args: PlacementEffectArgs):
	args.gameState.add_gold(amount)

func rules_text() -> String:
	return "Add %d gold" % amount

func keyword() -> String:
	return "Gold %d" % amount
