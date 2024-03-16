class_name DrawCard
extends Effect

var amount: int

func _init(cardsToDraw: int=1):
	amount = cardsToDraw

func resolve(args: EffectArgs):
	for i in range(amount):
		args.gameState.draw_card()

func rules_text() -> String:
	return "Draw a card"
