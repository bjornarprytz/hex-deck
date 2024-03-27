class_name Trade
extends Effect

func resolve(args: EffectArgs):
	var result = await Prompt.trade(args.gameState.hand)
	
	var cards = result[0]
	var effect = result[1]

	if (cards is Array[Card] and effect is Effect):
		for card in cards:
			args.gameState.banish_card(card)
		
		Events.onCardsBanished.emit(args, cards)
		await effect.resolve(args)

func rules_text() -> String:
	return "May banish 1 card for either 2 food or 1 gold"

func keyword() -> String:
	return "Trading"
