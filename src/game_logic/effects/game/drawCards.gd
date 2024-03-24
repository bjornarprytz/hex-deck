class_name DrawCards
extends Effect

var amount: int

func _init(cardsToDraw: int=1):
	amount = cardsToDraw

func resolve(args: EffectArgs):
	var cards: Array[Card] = []

	for i in range(amount):
		cards.push_back(args.gameState.draw_card())
	
	Events.onCardsDrawn.emit(args, cards)

func rules_text() -> String:
	return "Draw %d card(s)" % [amount]

func keyword() -> String:
	return "Draw %d" % [amount]

func abstract_keyword() -> String:
	return "Draw X"