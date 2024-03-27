class_name DiscardHand
extends Effect

func resolve(args: EffectArgs):
	var hand = args.gameState.hand
	var cards: Array[CardData] = []

	for card in hand.get_cards():
		if card.state.has_flag("retain"):
			card.state.set_flag("retain", false)
		else:
			cards.push_back(args.gameState.discard_card(card))
	
	Events.onCardsDiscarded.emit(args, cards)

func rules_text() -> String:
	return "Discard hand"

func keyword() -> String:
	return "Discard Hand"