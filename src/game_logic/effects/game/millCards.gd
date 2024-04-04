class_name MillCards
extends Effect

var amount: int
var cardPileEffect: CardPileEffect

func _init(inputAmount: int, inputEffect: CardPileEffect=null) -> void:
	amount = inputAmount
	cardPileEffect = inputEffect

func resolve(args: EffectArgs):
	var milledCards: Array[CardData] = []
	for i in range(amount):
		var milledCard = args.gameState.mill_card()
		if milledCard != null:
			milledCards.push_back(milledCard)
	
	args.gameState.infoQueue.push_card_info(milledCards, "Fishing:") # TODO: Put this in a signal handler instead
	if cardPileEffect != null:
		await cardPileEffect.resolve(CardPileEffectArgs.new(args.gameState, milledCards))

	Events.onCardsMilled.emit(args, milledCards)
