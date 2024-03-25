class_name RetainCards
extends Effect

var amount: int

func _init(inputAmount: int=1):
	self.amount = inputAmount

func resolve(args: EffectArgs):
	push_error("TODO: Implement RetainCards")

func rules_text() -> String:
	return "Retain %d Card(s)" % amount

func keyword() -> String:
	return "Retain %d" % amount
