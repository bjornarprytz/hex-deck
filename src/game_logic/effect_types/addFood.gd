class_name AddFood
extends Effect

var amount: int

func _init(inputAmount: int=1):
    amount = inputAmount

func resolve(args: EffectArgs):
    assert(amount > 0)
    args.gameState.food += amount

func rules_text() -> String:
    return "Add %d food" % amount