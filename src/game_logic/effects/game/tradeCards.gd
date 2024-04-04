class_name TradeCards
extends Effect

func resolve(args: EffectArgs):
	var result = await Prompt.trade(args.gameState.hand)
	
	var cards = result[0] as Array[Card]
	var effect = result[1]

	if (effect is Effect):
		for card in cards:
			args.gameState.banish_card(card)
		
		Events.onCardsBanished.emit(args, cards)
		await effect.resolve(args)
