class_name AddGold
extends StructureEffect

var amount: int

func _init(inputAmount: int=1):
	amount = inputAmount

func resolve(args: StructureEffectArgs):
	assert(amount > 0)
	args.gameState.add_gold(amount, args.affectedTiles)

func rules_text() -> String:
	return "Add %d gold" % amount
