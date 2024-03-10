class_name DrawCard
extends Effect

func resolve(args: PlayArgs):
	args.gameState.draw_card()

func rules_text() -> String:
	return "Draw a card"
