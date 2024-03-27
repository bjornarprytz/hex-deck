class_name RetainCards
extends Effect

var amount: int

func _init(inputAmount: int=1):
	self.amount = inputAmount

func resolve(args: EffectArgs):
	var cards = await Prompt.upToNFromHand(args.gameState.hand, amount, "Select up to %d card(s) to retain" % amount)

	for card in cards:
		card.state.set_flag("retain", true)

func rules_text() -> String:
	return "Retain %d Card(s)" % amount

func keyword() -> String:
	return "Retain %d" % amount
