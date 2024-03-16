class_name DiscardHand
extends Effect

func resolve(args: EffectArgs):
	var hand = args.gameState.hand
	
	for card in hand.get_cards():
		args.gameState.discard_card(card)

func rules_text() -> String:
	return "Discard hand"
