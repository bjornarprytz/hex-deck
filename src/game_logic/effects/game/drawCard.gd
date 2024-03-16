class_name DrawCard
extends GameEffect

func resolve(args: GameEffectArgs):
	args.gameState.draw_card()

func rules_text() -> String:
	return "Draw a card"
