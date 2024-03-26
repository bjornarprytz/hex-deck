class_name Fishing
extends Effect

var amount: int
var cardPileEffect: CardPileEffect

func _init(inputAmount: int, inputEffect: CardPileEffect) -> void:
	amount = inputAmount
	cardPileEffect = inputEffect

func resolve(args: EffectArgs):
	var milledCards: Array[CardData] = []
	for i in range(amount):
		var milledCard = args.gameState.mill_card()
		if milledCard != null:
			milledCards.push_back(milledCard)
			Debug.push_message("Milled %s, alignment: %s " % [milledCard.name, milledCard.alignment])
	
	await cardPileEffect.resolve(CardPileEffectArgs.new(args.gameState, milledCards))
	Events.onCardsMilled.emit(args, milledCards)

func rules_text():
	return "Mill %d cards and %s" % [amount, cardPileEffect.rules_text()]

func keyword():
	return "Fishing %d: %s" % [amount, cardPileEffect.keyword()]
