class_name DiscardCards
extends Effect

var amount: int

func _init(inputAmount: int=1):
	amount = inputAmount

func resolve(args: EffectArgs):
	if (amount == 0):
		return

	var hand = args.gameState.hand
	var cardsInHand = hand.get_cards()

	var discardedCards: Array[CardData] = []

	var cardsToDiscard: Array[Card] = []
	
	if (amount >= cardsInHand.size()):
		cardsToDiscard.append_array(cardsInHand)
	else:
		cardsToDiscard.append_array(await Prompt.nFromHand(hand, amount, "Discard %d cards." % amount, true))

	for card in cardsToDiscard:
		discardedCards.push_back(args.gameState.discard_card(card))

	Events.onCardsDiscarded.emit(args, discardedCards)

func rules_text() -> String:
	return "Discard %d cards" % amount

func keyword() -> String:
	return "Discard %d" % amount

func abstract_keyword() -> String:
	return "Discard X"
