class_name Trade
extends Effect



func resolve(args: EffectArgs):
	var result = await Prompt.trade(args.gameState.hand)
	
	var card = result[0]
	var effect = result[1]

	if (card is Card and effect is Effect):
		args.gameState.discard_card(card)
		Events.onCardsDiscarded.emit(args, [card])
		await effect.resolve(args)

func rules_text() -> String:
	return "May discard 1 card for either 2 food or 1 gold"


func keyword() -> String:
	return "Trading"
