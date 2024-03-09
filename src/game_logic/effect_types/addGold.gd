class_name AddGold
extends Effect

var amount: int

func _init(inputAmount: int=1):
    amount = inputAmount

func resolve(_args: PlayArgs):
    assert(amount > 0)
    Meta.gold += amount

func rules_text() -> String:
    return "Add %d gold" % amount