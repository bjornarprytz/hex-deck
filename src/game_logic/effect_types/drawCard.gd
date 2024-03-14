class_name DrawCard
extends Effect

func resolve(args: EffectArgs):
	args.gameState.draw_card()

func rules_text() -> String:
	return "Draw a card"
